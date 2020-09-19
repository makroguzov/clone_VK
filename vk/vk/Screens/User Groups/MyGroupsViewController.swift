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
        
        getGroupsFromNetwork()
    }
}

extension MyGroupsViewController {
    func getGroupsFromNetwork(){

    }
    
    func getFilteredGroups() {
        
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
