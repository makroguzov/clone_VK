//
//  MyGroupsViewController.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit
import JGProgressHUD

class MyGroupsViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let group = DispatchGroup()

    
    private var viewModel: GroupsViewModel!
    private let progressHud = JGProgressHUD(style: .dark)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = GroupsViewModel(tableView: tableView)
        
        setUpTableView()
        loadData()
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MyGroupsViewController {
    private func loadData() {
        
        progressHud.show(in: self.view, animated: true)
        
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) { [weak self] in
            self?.group.enter()
            self?.loadGroups()
        }

        DispatchQueue.global(qos: .userInteractive).async(group: group) { [weak self] in
            //self?.group.enter()
            self?.loadInvitations()
        }
       
        group.notify(queue: .main) { [weak self] in
            self?.tableView.reloadData()
            self?.progressHud.dismiss(animated: true)
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
            DispatchQueue.global(qos: .userInteractive).async {
                self?.group.leave()
                self?.viewModel.setUp(with: groups)
            }
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
        
        NetworkService.shared.loadJSON(with: request)
        
        NetworkService.shared.loadData(with: request) { [weak self] (invitations: UserGroupInvitationModel) in
            DispatchQueue.global(qos: .userInteractive).async {
                self?.group.leave()
                self?.viewModel.setUp(with: invitations)
            }
        }
    }
}

extension MyGroupsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.titleForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.cellForRowAt(indexPath: indexPath)
    }
}

extension MyGroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.heightForRowAt(indexPath: indexPath)
    }
    
}
