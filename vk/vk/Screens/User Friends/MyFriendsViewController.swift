//
//  MyFriendsViewController.swift
//  vk
//
//  Created by MACUSER on 24.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit
import RealmSwift

extension MyFriendsViewController {
    enum Sections: Int, CaseIterable {
        case first, second, third
    }
}

class MyFriendsViewController: UITableViewController {
   
    private let realmService = RealmService.shared
 
    
    private let searcController = UISearchController(searchResultsController: nil)
    
    
    private var friendsAmount: Int {
        let userFriendsModel: UserFriendsModel? = realmService?.getObjects().first
        return userFriendsModel?.count ?? 0
    }
    
    
    
    private var mostImportantFriendCellModels: Slice<List<UserModel>>? {
        let userFriendsModel: UserFriendsModel? = realmService?.getObjects().first
        let users = userFriendsModel?.users[0..<5]
        
        return users
    }
    private var friendCellModels: Results<UserModel>? {
        let userFriendsModel: UserFriendsModel? = realmService?.getObjects().first
        let users  = userFriendsModel?.users.sorted(byKeyPath: "id")
        
        return users
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registes tableView cells, headers
        tableView.register(GroupHeader.self, forHeaderFooterViewReuseIdentifier: "GroupHeader")
        
        
        // Set up the search controller
        searcController.searchResultsUpdater = self
        searcController.obscuresBackgroundDuringPresentation = false
        searcController.searchBar.placeholder = "Поиск"
        
        navigationItem.searchController = searcController
        definesPresentationContext = true
        
        
        // Load data from Network
        loadDataFromNetwork()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
}

//MARK: - Network

extension MyFriendsViewController {
    
    func loadDataFromNetwork(completion: (() -> Void)? = nil) {
        
        NetworkService.shared.loadUserFriends(user_id: Session.shared.userId, order: "hints", list_id: "", count: 500, offset: 0, fields: "photo_200,city,bdate", name_case: "", ref: "") { [weak self] (userFriendsModel) in

            DispatchQueue.main.async {
                try? self?.realmService?.add(object: userFriendsModel)
                self?.tableView.reloadData()
                completion?()
            }
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
            return mostImportantFriendCellModels?.count ?? 0
        case .third:
            return friendCellModels?.count ?? 0
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
            
            cell.model = mostImportantFriendCellModels?[indexPath.row]
            
            return cell
        case .third:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as? FriendCell else {
                fatalError()
            }
            
            cell.model = friendCellModels?[indexPath.row]
            
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

extension MyFriendsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
