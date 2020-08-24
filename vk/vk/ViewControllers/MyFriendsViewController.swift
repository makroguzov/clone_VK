//
//  MyFriendsViewController.swift
//  vk
//
//  Created by MACUSER on 24.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

extension MyFriendsViewController {
    enum Sections: Int, CaseIterable {
        case first, second, third
    }
}

class MyFriendsViewController: UITableViewController {
    private var mostImportantFriendCellModels = [FriendsCellModel]()
    private var friendCellModels = [FriendsCellModel]()
    private var friendsAmount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(GroupHeader.self, forHeaderFooterViewReuseIdentifier: "GroupHeader")
        
        getInitData()
    }
}

//MARK: - Network

extension MyFriendsViewController {
    func getInitData() {
        self.tableView.beginUpdates()
        getFriends()
    }
    
    func getFriends() {
        NetworkService.shared.loadUserFriends(user_id: Session.shared.userId, order: "hints", list_id: "", count: 500, offset: 0, fields: "photo_200,city,bdate", name_case: "", ref: "") { [weak self] (userFriendsModel) in
            
            let friends = userFriendsModel.users
            let friendsAmount = userFriendsModel.count
            
    
            let numberOfRows = self?.friendCellModels.count ?? 0
            self?.tableView.insertRows(at: Array(numberOfRows ..< numberOfRows + friends.count).map { IndexPath(row: $0, section: Sections.third.rawValue) }, with: .automatic)
            
            for friend in friends {
                let model = FriendsCellModel(image: friend.photo200, name: friend.firstName, surename: friend.lastName, bdate: friend.bdate, city: friend.city)
                self?.friendCellModels.append(model)
            }
            
            
            self?.friendsAmount = friendsAmount
            
            
            guard let friendCellModels = self?.friendCellModels else { return }
            let mostImportantFriendCellModelsCount = friendCellModels.count < 5 ? friendCellModels.count : 5
            //self?.mostImportantFriendCellModels = Array(friendCellModels[0 ..< mostImportantFriendCellModelsCount])
            self?.mostImportantFriendCellModels = Array(repeating: friendCellModels[0], count: 5)
            
            self?.tableView.insertRows(at: Array(0 ..< mostImportantFriendCellModelsCount).map { IndexPath(row: $0, section: Sections.second.rawValue) }, with: .automatic)
            
            
            self?.tableView.endUpdates()
            //self.tableView.reloadData()
        }
    }
}

//MARK: - Datasource

extension MyFriendsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = Sections(rawValue: section)
        
        switch section {
        case .first:
            return 1
        case .second:
            return mostImportantFriendCellModels.count
        case .third:
            return friendCellModels.count
        default:
            print("error: invalid section.")
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = Sections(rawValue: indexPath.section)
        
        switch section {
        case .first:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupFirstSectionCell") as? GroupFirstSectionCell else {
                fatalError()
            }

            return cell
        case .second:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as? FriendCell else {
                fatalError()
            }
            
            cell.model = mostImportantFriendCellModels[indexPath.row]
            
            return cell
        case .third:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as? FriendCell else {
                fatalError()
            }
            
            cell.model = friendCellModels[indexPath.row]
            
            return cell
        default:
            print("error: invalid section.")
            fatalError()
        }
    }
}

 //MARK: - Delegate

extension MyFriendsViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = Sections(rawValue: indexPath.section)
        
        switch section {
        case .first:
            return 60
        case .second, .third:
            return 60
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "GroupHeader") as? GroupHeader else {
            fatalError()
        }
    
        let section = Sections(rawValue: section)
        switch section {
        case .first:
            header.model = .firstSection
            return header
        case .second:
            header.model = .mostImportantFriendsSection
            return header
        case .third:
            header.model = .friendsSection(.init(friendsAmount: friendsAmount))
            return header
        default:
            return header
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = Sections(rawValue: section)
        
        switch section {
        case .first:
            return 60
        case .second:
            return 50
        case .third:
            return 50
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

