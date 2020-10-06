//
//  UserGroupsModel.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation

struct UserGroupsModel: Codable {
    enum CodingKeys: String, CodingKey {
        case groups = "items"
        case count
    }
    
    let count: Int
    let groups: [GroupModel]
}

