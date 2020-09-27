//
//  GroupModel.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation

struct GroupModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case isAdmin = "is_admin"
        case isAdvertiser = "is_advertiser"
        case isClosed = "is_closed"
        case isMember = "is_member"
        case name
        case screenName = "screen_name"
        case photo = "photo_100"
    }
    
    let id: Int
    
    let isAdmin: Int
    let isAdvertiser: Int
    let isClosed: Int
    let isMember: Int
    
    let name: String
    let screenName: String

    let photo: String?
    //let photo_200: String?
    //let photo_50: String?
}
