//
//  NewsViewController.swift
//  vk
//
//  Created by MACUSER on 19.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var postFactory: PostFactory = PostFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUpTableView()
        loadDataFromNetwork()
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func loadDataFromNetwork() {
        
    }
}

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return postFactory.heightForHeaderInSection(tableView, heightForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return postFactory.viewForHeaderInSection(tableView, viewForHeaderInSection: section)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return postFactory.heightForRowAt(tableView, heightForRowAt: indexPath)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return postFactory.heightForFooterInSection(tableView, heightForFooterInSection: section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return postFactory.viewForFooterInSection(tableView, viewForFooterInSection: section)
    }
    
}

extension NewsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return postFactory.numberOfSections(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postFactory.numberOfRowsInSection(tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return postFactory.cellForRowAt(tableView, cellForRowAt: indexPath)
    }
}
