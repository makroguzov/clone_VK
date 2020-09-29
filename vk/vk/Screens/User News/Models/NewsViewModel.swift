//
//  PostFactory.swift
//  vk
//
//  Created by MACUSER on 20.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class NewsViewModel {
    
    enum NewsViewModelErrors: Error {
        case creatorIsUndefinded(Int)
        case creatorIdIsNil
    }
    
    
    private var tableView: UITableView!
    
    private var postModels = [SectionModel]()
    
    init(_ tableView: UITableView) {
        self.tableView = tableView
    }
    
    
    func numberOfSections() -> Int {
        return postModels.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return postModels[section].postCells.count
    }
    
    
    
    func cellForRowAt(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row

        let model = postModels[section].postCells[row]
        let cell = model.getCell(tableView, by: row)
        return cell
    }
    
    private func getCellBy(_ identifier: String) {
        
    }
    
    func heightForRowAt(heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        let row = indexPath.row
        
        return postModels[section].postCells[row].height
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

 

    func setUpAsync(with newsFeed: NewsFeed) {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.setUp(with: newsFeed)
            self?.tableView?.reloadData()
        }
     }
    
    private func setUp(with newsFeed: NewsFeed) {
        let posts = newsFeed.posts
        let creators = (newsFeed.groups, newsFeed.profiles)
        
        
        for post in posts {

            let creatorId = post.sourceId
            
            do {
                let creator = try getCreator(by: creatorId, from: creators)
                let postModel = SectionModel(post: post, creator: creator)
                self.postModels.append(postModel)

            } catch NewsViewModelErrors.creatorIdIsNil {
                print("Creator for post: \(post.id)")
                continue
            } catch let NewsViewModelErrors.creatorIsUndefinded(creatorId) {
                print("Can't find creator by id: \(creatorId).")
                continue
            } catch {
                print("Unknowed error.")
                return
            }
        }
    }
    
    private func getCreator(by creatorId: Int? , from creators: ([GroupModel], [UserModel])) throws -> Creator {
        guard let creatorId = creatorId else {
            throw NewsViewModelErrors.creatorIdIsNil
        }
        
        let (gropus, profiles) = creators
        var creator = Creator()
        
        if creatorId < 0 {
            guard let group = gropus.filter({ $0.id == abs(creatorId) }).first else {
                throw NewsViewModelErrors.creatorIsUndefinded(creatorId)
            }
            
            creator.setParams(name: group.name, subtitle: group.screenName, photo: group.photo)
            
        } else {
            guard let profile = profiles.filter({ $0.id == creatorId }).first else {
                throw NewsViewModelErrors.creatorIsUndefinded(creatorId)
            }
            
            creator.setParams(name: profile.name, subtitle: profile.description, photo: profile.photo100)
        }
        
        return creator
    }
    
}
