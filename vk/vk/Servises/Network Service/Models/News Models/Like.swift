//
//  Like.swift
//  vk
//
//  Created by Валерий Макрогузов on 26.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation

struct Like: Codable {
    enum CodingKeys: String, CodingKey {
        case count
        case isUserLike = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
    
    let count: Int
    let isUserLike: Bool
    let canLike: Bool
    let canPublish: Bool
    
}
