//
//  PostFactory.swift
//  vk
//
//  Created by MACUSER on 20.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class PostFactory {
    
    private let syncQueue = DispatchQueue(label: "PostFactorySyncQueue", attributes: .concurrent)
    
    private var postModels = [PostModel]()
    private var tableView: UITableView?
    
    
    func numberOfSections() -> Int {
        return postModels.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if section < postModels.count {
            return postModels[section].postCells.count
        }
        else {
            return 0
        }
    }
    
    
    
    func cellForRowAt(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func heightForRowAt(heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 100
    }
    
    
    
    func heightForHeaderInSection(heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    func viewForHeaderInSection(viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
        
    
    
    func heightForFooterInSection(heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func viewForFooterInSection(viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

 

    func setUp(_ tableView: UITableView, with newsFeed: NewsFeed) {
        self.tableView = tableView
        
        let setUpTasks = DispatchGroup()
        
        DispatchQueue.global(qos: .userInteractive).async(group: setUpTasks) { [weak self] in
            let posts = newsFeed.posts
            self?.setUpPosts(posts: posts)
        }
    
        setUpTasks.notify(qos: .userInteractive, queue: .main) { [weak self] in
            self?.tableView?.reloadData()
        }
     }
    
    private func setUpPosts(posts: [Post]) {
        for post in posts {
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                let postModel = PostModel(post: post)
                self?.append(postModel)
            }
        }
    }
    
    private func append(_ postModel: PostModel) {
        syncQueue.async(flags: .barrier) { [weak self] in
            self?.postModels.append(postModel)
        }
    }
}
