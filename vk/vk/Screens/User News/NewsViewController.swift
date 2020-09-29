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
    
    private var viewModel: NewsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewModel = NewsViewModel(tableView)
        
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
        
        //NetworkService.shared.loadJSON(with: request)
        
        NetworkService.shared.loadData(with: request) { [weak self] (newsFeed: NewsFeed) in
            self?.viewModel.setUpAsync(with: newsFeed)
        }
    }
}

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.heightForHeaderInSection(heightForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewModel.viewForHeaderInSection(viewForHeaderInSection: section)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(heightForRowAt: indexPath)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.heightForFooterInSection(heightForFooterInSection: section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return viewModel.viewForFooterInSection(viewForFooterInSection: section)
    }
    
}

extension NewsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellForRowAt(cellForRowAt: indexPath)
    }
}
