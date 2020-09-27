//
//  PostFactory.swift
//  vk
//
//  Created by MACUSER on 20.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class PostFactory {
    
    private var postModels = [PostModel]()
    
    
    
    func numberOfSections(_ tableView: UITableView) -> Int {
        return postModels.count
    }
    
    func numberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        if section < postModels.count {
            return postModels[section].postCells.count
        }
        else {
            return 0
        }
    }
    
    
    
    func cellForRowAt(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func heightForRowAt(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 100
    }
    
    
    
    func heightForHeaderInSection(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    func viewForHeaderInSection(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
        
    
    
    func heightForFooterInSection(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func viewForFooterInSection(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

 

    func setUp(_ tableView: UITableView, with posts: [Post]) {
        for post in posts {
            let postModel = PostModel(post: post)
            postModels.append(postModel)
        }
    }
}
