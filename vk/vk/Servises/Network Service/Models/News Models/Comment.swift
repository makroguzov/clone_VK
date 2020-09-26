//
//  Comment.swift
//  vk
//
//  Created by Валерий Макрогузов on 26.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation

struct Comment: Codable {
    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
    }
    
    let count: Int
    let canPost: Bool
}
