//
//  NewsFeed.swift
//  vk
//
//  Created by MACUSER on 20.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation

struct NewsFeed: Codable {
    enum CodingKeys: String, CodingKey {
        case posts = "items"
        //case profiles
        //case groups
        //case newOffset = "new_offset"
    }

    var posts: [Post]
}
