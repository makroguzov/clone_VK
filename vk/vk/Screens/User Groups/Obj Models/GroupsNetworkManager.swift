//
//  GroupsNetworkManager.swift
//  vk
//
//  Created by Валерий Макрогузов on 06.10.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import JGProgressHUD
import UIKit

enum GroupsNetworkResults {
    case error(GroupsNetworkManager.Errors)
    case sucsess(UserGroupsModel, UserGroupInvitationModel)
}

class GroupsNetworkManager {
    
    enum Errors: Error {
        case viewControllerIsNotExist
        case loadGroupsError
        case loadInvitationsError
    }
    
    private let progressHud = JGProgressHUD(style: .dark)
    private let viewController: UIViewController
    
    private let group = DispatchGroup()

    private var groups: UserGroupsModel?
    private var invitations: UserGroupInvitationModel?
    
    init(controller: UIViewController) {
        self.viewController = controller
    }
    
    func loadData(complition: @escaping (GroupsNetworkResults) -> Void) {
        
        progressHud.show(in: viewController.view, animated: true)
        
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) { [weak self] in
            self?.group.enter()
            self?.loadGroups()
        }

        DispatchQueue.global(qos: .userInteractive).async(group: group) { [weak self] in
            self?.group.enter()
            self?.loadInvitations()
        }
       
        
        group.notify(queue: .main) { [weak self] in
            self?.progressHud.dismiss(animated: true)
            
            let result: GroupsNetworkResults
            
            guard let self = self else {
                result = .error(.viewControllerIsNotExist)
                complition(result)
                return
            }
            
            guard let groups = self.groups else {
                result = .error(.loadGroupsError)
                complition(result)
                return
            }
            
            guard let invitations = self.invitations else {
                result = .error(.loadInvitationsError)
                complition(result)
                return
            }
            
            result = .sucsess(groups, invitations)
            complition(result)
        }
    }
    
    private func loadGroups(){
        let request = VKRequestParametrs()
        request.set(path: .groups)

        let params: [String: Any] = [
            "user_id": Session.shared.userId,
            "extended": 1
        ]
        request.set(params: params)
        
        NetworkService.shared.loadData(with: request) { [weak self] (groups: UserGroupsModel) in
            self?.group.leave()
            self?.groups = groups
        }
    }
        
    private func loadInvitations() {
        let request = VKRequestParametrs()
        request.set(path: .invites)
        
        let params: [String: Any] = [
            "user_id": Session.shared.userId,
            "extended": 1
        ]
        request.set(params: params)
        
        //NetworkService.shared.loadJSON(with: request)
        
        NetworkService.shared.loadData(with: request) { [weak self] (invitations: UserGroupInvitationModel) in
            self?.group.leave()
            self?.invitations = invitations
        }
    }

}
