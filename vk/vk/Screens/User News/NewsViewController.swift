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
        let request = VKRequestParametrs()
        request.set(path: .newsfeed)
        
        NetworkService.shared.loadData(with: request) { [weak self] (newsFeed: NewsFeed) in
            guard let self = self else {
                print("load data error.")
                return
            }
            self.postFactory.setUp(self.tableView, with: newsFeed)
        }
    }
}

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return postFactory.heightForHeaderInSection(heightForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return postFactory.viewForHeaderInSection(viewForHeaderInSection: section)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return postFactory.heightForRowAt(heightForRowAt: indexPath)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return postFactory.heightForFooterInSection(heightForFooterInSection: section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return postFactory.viewForFooterInSection(viewForFooterInSection: section)
    }
    
}

extension NewsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return postFactory.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postFactory.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return postFactory.cellForRowAt(cellForRowAt: indexPath)
    }
}
