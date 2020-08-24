//
//  MyGroupsViewController.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class MyGroupsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    private var cellGroupModels = [GroupCellModel]()
    private var totalGroupsCount: Int = 0
    private var offset: Int = 0
    
    private var cellGroupInvitationModels = [GroupInvitationCellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getInitData()
    }
}

extension MyGroupsViewController {
    func getInitData() {
        getGroups(count: 100)
        //loadUserGroupInvitations()
    }
    
    func getGroups(count: Int){
        NetworkService.shared.loadUserGroups(userId: Session.shared.userId, extended: 1, filter: "", fields: "", offset: 0, count: count) { [weak self] (userGroupModel) in
            guard let self = self else { return }
            
            self.tableView.beginUpdates()
            
            let totalGroupsCount = userGroupModel.response.count
            let groups = userGroupModel.response.groups
            
            let numberOfRows = self.cellGroupModels.count
            self.tableView.insertRows(at: Array(numberOfRows ..< numberOfRows + groups.count).map { IndexPath(row: $0, section: 1) }, with: .automatic)

            
            for group in groups {
                let groupCellModel = GroupCellModel(image: group.photo_200, groupName: group.name, groupSubtitle: group.screen_name)
                self.cellGroupModels.append(groupCellModel)
            }
            self.totalGroupsCount = totalGroupsCount

            self.offset += count
            
            self.tableView.reloadData()
            self.tableView.endUpdates()
        }
    }
    
    func getFilteredGroups() {
        
    }
    
    func loadUserGroupInvitations() {
        NetworkService.shared.loadUserGroupInvitations(offset: 0, count: 2, extended: 1) { [weak self] (userGroupInvitationModel) in
            guard let self = self else { return }
            
            self.tableView.beginUpdates()
            
            let events = userGroupInvitationModel.response.events
            let invitorGroups: [Int: [GroupModel]] = Dictionary(grouping: userGroupInvitationModel.response.invitorGroups) { $0.id }
            let invitorUsers: [Int: [UserModel]] =  Dictionary(grouping: userGroupInvitationModel.response.invitorUsers) { $0.id }
        
            for event in events {
                if let invitor = invitorGroups[abs(event.is_advertiser)]{
                    let invitor = invitor[0]
                    let groupInvitationCell = GroupInvitationCellModel(eventImage: event.photo_200, invitorImage: "", eventName: event.name, countOfParticipants: "", invitorName: invitor.name)
                    self.cellGroupInvitationModels.append(groupInvitationCell)
                } else if let invitor = invitorUsers[event.is_advertiser] {
                    let invitor = invitor[0]
                    //let groupInvitationCell = GroupInvitationCellModel(eventImage: event.photo_200, invitorImage: "", eventName: event.name, countOfParticipants: "", invitorName: invitor.lastName)
                    //self.cellGroupInvitationModels.append(groupInvitationCell)
                }
            }
            
            self.tableView.reloadData()
            self.tableView.endUpdates()
        }
    }
}

extension MyGroupsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Все сообщества \(totalGroupsCount)"
        default:
            return "Приглашения"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return cellGroupModels.count
        default:
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell") as? GroupCell else {
                fatalError()
            }
            
            cell.model = cellGroupModels[indexPath.row]
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupInvitationCell") as? GroupInvitationCell else {
                fatalError()
            }
            
            cell.model =  .emptyState //cellGroupInvitationModels[indexPath.row]
            
            return cell
        }
    }
}

extension MyGroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 1 ? 70 : 110
    }
    
}
