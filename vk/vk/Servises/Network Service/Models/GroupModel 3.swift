//
//  GroupModel.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation

struct GroupModel: Decodable {
    let id: Int
    
    let is_admin: Int
    let is_advertiser: Int
    let is_closed: Int
    let is_member: Int
    
    let name: String
    let screen_name: String

    let photo_100: String?
    let photo_200: String?
    let photo_50: String?
    
//    let type: String
}
