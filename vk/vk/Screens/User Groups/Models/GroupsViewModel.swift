//
//  GroupsViewModel.swift
//  vk
//
//  Created by Валерий Макрогузов on 27.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class GroupsViewModel {
    
    enum Section: Int {
        case invitations = 0
        case groups = 1
    }
    
    private let tableView: UITableView
    
    private var cellGroupModels = [GroupCellModel]()
    private var cellGroupInvitationModels = [GroupInvitationCellModel]()
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func setUp(with groups: UserGroupsModel) {
        let groups  = groups.groups
        
        for group in groups {
            let model = GroupCellModel(image: group.photo, groupName: group.name, groupSubtitle: group.screenName)
            cellGroupModels.append(model)
        }
        
        print(12)
    }
    
    func setUp(with invitations: UserGroupInvitationModel) {
        
    }
    
    func numberOfSections() -> Int {
        return 2
    }
    
    func titleForHeaderInSection(section: Int) -> String? {
        let section = Section(rawValue: section)
        switch section {
        case .groups:
            return "группы"
        case .invitations:
            return "приглашения"
        case .none:
            print("invalid number of section")
            fatalError()
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        let section = Section(rawValue: section)
        switch section {
        case .groups:
            return cellGroupModels.count
        case .invitations:
            return 2
        case .none:
            print("invalid number of section")
            fatalError()
        }
    }
    
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell {
        let section = Section(rawValue: indexPath.section)
        switch section {
        case .groups:
            let cell = getGroupCellAt(indexPath)
            return cell
        case .invitations:
            let cell = getInvitationCellAt(indexPath)
            return cell
        case .none:
            print("invalid number of section")
            fatalError()
        }
    }

    private func getGroupCellAt(_ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.identifier) as? GroupCell else {
            fatalError()
        }

        cell.model = cellGroupModels[indexPath.row]
        return cell
            
    }
    
    private func getInvitationCellAt(_ indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
        //        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupInvitationCell.identifier) as? GroupInvitationCell else {
//            fatalError()
//        }
//
//        cell.model = cellGroupInvitationModels[indexPath.row]
//        return cell
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        let section = Section(rawValue: indexPath.section)
        switch section {
        case .groups:
            return GroupCell.heigth
        case .invitations:
            return GroupInvitationCell.heigth
        case .none:
            print("invalid number of section")
            fatalError()
        }
    }
    
}
