//
//  MyFriendsViewController.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
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
        
        getInitData()
    }
}

extension MyFriendsViewController {
    func getInitData() {
        self.tableView.beginUpdates()
        getFriends()
    }
    
    func getFriends() {
        NetworkService.shared.loadUserFriends(user_id: Session.shared.userId, order: "hints", list_id: "", count: 500, offset: 0, fields: "photo_200_orig,city,bdate", name_case: "", ref: "") { [weak self] (userFriendsModel) in
            
            let friends = userFriendsModel.response.users
            let friendsAmount = userFriendsModel.response.count
            
    
            let numberOfRows = self?.friendCellModels.count ?? 0
            self?.tableView.insertRows(at: Array(numberOfRows ..< numberOfRows + friends.count).map { IndexPath(row: $0, section: Sections.third.rawValue) }, with: .automatic)
            
            for friend in friends {
                let model = FriendsCellModel(image: friend.photo_200_orig, name: friend.first_name, surename: friend.last_name, bdate: friend.bdate, city: friend.city)
                self?.friendCellModels.append(model)
            }
            
            
            self?.friendsAmount = friendsAmount
            
            
            guard let friendCellModels = self?.friendCellModels else { return }
            let mostImportantFriendCellModelsCount = friendCellModels.count < 5 ? friendCellModels.count : 5
            self?.mostImportantFriendCellModels = Array(friendCellModels[0 ..< mostImportantFriendCellModelsCount])
                
            self?.tableView.insertRows(at: Array(0 ..< mostImportantFriendCellModelsCount).map { IndexPath(row: $0, section: Sections.second.rawValue) }, with: .automatic)
            
            
            self?.tableView.endUpdates()
            //self.tableView.reloadData()
        }
    }
}

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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as? FriendCell else {
                fatalError()
            }
            
            cell.model = .emptyState //friendCellModels[indexPath.row]
            
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
extension MyFriendsViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = Sections(rawValue: indexPath.section)
        
        switch section {
        case .first:
            return 120
        case .second, .third:
            return 60
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = Sections(rawValue: section)
        
        switch section {
        case .first:
            return 50
        case .second, .third:
            return 20
        default:
            return 0
        }
    }
}

