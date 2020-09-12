//
//  UserGroupsModel.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation

struct UserGroupsModel: Decodable {
    let response: Response
}

extension UserGroupsModel {
    struct Response: Decodable {
        enum CodingKeys: String, CodingKey {
            case groups = "items"
            case count
        }

        let count: Int
        let groups: [GroupModel]
    }
}

