//
//  MyFriendsViewController.swift
//  vk
//
//  Created by MACUSER on 24.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

extension MyFriendsViewController {
    enum Sections: Int, CaseIterable {
        case first, second, third
    }
}

class MyFriendsViewController: UITableViewController {
   
    private let realmService = RealmService.shared
 
    
    private lazy var customRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
            
            refreshControl.tintColor = .systemBlue
            refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        return refreshControl
    }()
    
    
    private lazy var searcController: UISearchController = UISearchController(searchResultsController: nil)
        
    private var searchBarIsEmpty: Bool {
        guard let text = searcController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searcController.isActive && !searchBarIsEmpty
    }
    
    
    private var friendsAmount: Int {
        let userFriendsModel: Results<UserFriendModel>? = realmService?.getObjects()
        return userFriendsModel?.count ?? 0
    }
    
    
    private var friendCellModelsNotificationToken: NotificationToken?
    private var mostImportantFriendCellModelsNotificationToken: NotificationToken?
    
    
    private var mostImportantFriendCellModels: Results<UserFriendModel>? {
        return realmService?.getObjects()
    }
    private var friendCellModels: Results<UserFriendModel>? {
        return realmService?.getObjects().sorted(byKeyPath: "id")
    }
    private var filteredFriendCellModels: Results<UserFriendModel>?


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSearchController()
        createNotifications()

        loadDataFromNetwork()
    }
    
    deinit {
        friendCellModelsNotificationToken?.invalidate()
        mostImportantFriendCellModelsNotificationToken?.invalidate()
    }
    
    
    
    private func setupTableView() {
        tableView.register(GroupHeader.self, forHeaderFooterViewReuseIdentifier: "GroupHeader")
        tableView.refreshControl = customRefreshControl
    }
    
    private func setupSearchController() {
        navigationItem.searchController = searcController
        definesPresentationContext = true
        
        searcController.searchResultsUpdater = self
        searcController.obscuresBackgroundDuringPresentation = false
        searcController.searchBar.placeholder = "Поиск"
    }
    
    private func createNotifications() {
        
        friendCellModelsNotificationToken = friendCellModels?.observe({ [weak self] (changes) in
            
            switch changes {
            case let .initial(friends):
                
                #if DEBUG
                 print("Initialized \(friends.count)")
                #endif
                
            case let .update(_, deletions: deletions, insertions: insertions, modifications: modifications):
                
                let section = Sections.third.rawValue

                #if DEBUG
                 print("deleted \(deletions.count): \(deletions)")
                 print("inserted \(insertions.count): \(insertions)")
                 print("modified \(modifications.count): \(modifications)")
                #endif

                self?.tableView.beginUpdates()
                 self?.tableView.deleteRows(at: deletions.map { IndexPath(item: $0, section: section) }, with: .automatic)
                 self?.tableView.insertRows(at: insertions.map { IndexPath(item: $0, section: section) }, with: .automatic)
                 self?.tableView.reloadRows(at: modifications.map { IndexPath(item: $0, section: section) }, with: .automatic)
                self?.tableView.endUpdates()
                
            case let .error(error):
                print(error.localizedDescription)
            }
        })
        
        mostImportantFriendCellModelsNotificationToken = mostImportantFriendCellModels?.observe({ [weak self] (changes) in
            
            switch changes {
            
            case let .initial(friends):
       
                #if DEBUG
                 print("Initialized \(friends.count)")
                #endif

            case let .update(_, deletions: deletions, insertions: insertions, modifications: modifications):
                
                let section = Sections.second.rawValue
                
                #if DEBUG
                 print("deleted \(deletions.count): \(deletions)")
                 print("inserted \(insertions.count): \(insertions)")
                 print("modified \(modifications.count): \(modifications)")
                #endif
                
                self?.tableView.beginUpdates()
                 self?.tableView.deleteRows(at: deletions.filter {$0 < 5}.map { IndexPath(item: $0, section: section) }, with: .automatic)
                 self?.tableView.insertRows(at: insertions.filter {$0 < 5}.map { IndexPath(item: $0, section: section) }, with: .automatic)
                 self?.tableView.reloadRows(at: modifications.filter {$0 < 5}.map { IndexPath(item: $0, section: section) }, with: .automatic)
                self?.tableView.endUpdates()
                
            case let .error(error):
                print(error.localizedDescription)
            }

        })
    }
    
    
    
    @objc private func refresh(_ sender: UIRefreshControl) {
        
        try? self.realmService?.deleteAll()
        
        loadDataFromNetwork { [weak self] in
            self?.refreshControl?.endRefreshing()
        }
    }

    @IBAction func logOutAction(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {
            showAlert(title: "error", message: error.localizedDescription)
        }
    }
}

//MARK: - Network

extension MyFriendsViewController {
    
    func loadDataFromNetwork(completion: (() -> Void)? = nil) {
        NetworkService.shared.loadData(with: .init(path: .friends, params: [
                "order": "hints",
                "count": 500,
                "fields": "photo_200,city,bdate"
        ])) { [weak self] (userFriendsModel: UserFriendsModel) in
            DispatchQueue.main.async {
                try? self?.realmService?.add(objects: userFriendsModel.friends)
                completion?()
            }
        }
    }
}

//MARK: - Datasource

extension MyFriendsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return isFiltering ? 1 : Sections.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredFriendCellModels?.count ?? 0
        }
        
        
        let section = Sections(rawValue: section)
        
        switch section {
        
        case .first:
            return 1
        
        case .second:
            let count = mostImportantFriendCellModels?.count ?? 0
            return count < 5 ? count : 5
        
        case .third:
            return friendCellModels?.count ?? 0
        
        case .none:
            print("error: invalid section.")
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isFiltering {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as? FriendCell else { fatalError() }
            
            cell.model = filteredFriendCellModels?[indexPath.row]
            return cell
        }
        
        
        let section = Sections(rawValue: indexPath.section)
        
        switch section {
        
        case .first:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupFirstSectionCell") as? GroupFirstSectionCell else { fatalError()
            }
            return cell
        
        case .second:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as? FriendCell else { fatalError() }
            let count = mostImportantFriendCellModels?.count ?? 0
            let row = indexPath.row
            
            cell.model = row < count ? mostImportantFriendCellModels?[indexPath.row] : nil
            return cell
        
        case .third:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as? FriendCell else { fatalError() }
            
            let count = friendCellModels?.count ?? 0
            let row = indexPath.row
            
            cell.model = row < count ? friendCellModels?[indexPath.row] : nil
            
            return cell
        
        case .none:
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
        
        case .none:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard !isFiltering else { return nil }
        
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
        
        case .none:
            return header
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard !isFiltering else { return 0 }
        
        let section = Sections(rawValue: section)
        switch section {
        
        case .first:
            return 60
        
        case .second:
            return 50
        
        case .third:
            return 50
        
        case .none:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? GroupHeader, section != 0 {
            header.drawSeparator(inset: 15)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

 //MARK: - Search

extension MyFriendsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchString(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchString(_ searchString: String) {
        let predicate = NSPredicate(format: "firstName BEGINSWITH[cd] %@ OR lastName BEGINSWITH[cd] %@", searchString.lowercased(), searchString.lowercased())
        filteredFriendCellModels = friendCellModels?.filter(predicate)
        
        tableView.reloadData()
    }
}
