//
//  Post.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class Post: Codable {
    let type: String 
    let source_id: Int
    let date: String
 
    let text: String?
    let photos: Photo?
    let geo: Geo?

    let coments: Comment
    let likes: Like
    let reposts: Repost
    //let attacments: Attacments
    
}
