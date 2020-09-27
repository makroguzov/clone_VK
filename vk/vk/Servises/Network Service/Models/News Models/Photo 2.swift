//
//  Photo.swift
//  vk
//
//  Created by Валерий Макрогузов on 26.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation

struct Photo: Codable {
    enum Codingkeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case albumId = "album_id"
        case liteImageUrl = "src"
        case fullImageUrl = "src_big"
    }
    
    let id: Int
    let ownerId: Int
    let albumId: Int
    let liteImageUrl: String
    let fullImageUrl: String
}
