//
//  Post.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

struct Post: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id = "post_id"
        case sourceId = "source_id"

        case date
        case text
//        case geo

        case comments
        case likes
        case reposts
    }
    
    let id: Int
    let sourceId: Int?

    let date: Int?
    let text: String?
//    let geo: Geo?

    let comments: Comment?
    let likes: Like?
    let reposts: Repost?
    //let attacments: Attacments
    
}
