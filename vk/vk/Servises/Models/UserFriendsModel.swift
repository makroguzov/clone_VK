//
//  UserFriendsModel.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation

struct UserFriendsModel: Decodable {
    let response: Response
}

extension UserFriendsModel {
    struct Response: Decodable {
        enum CodingKeys: String, CodingKey {
            case users = "items"
            case count
        }

        let count: Int
        let users: [UserModel]
    }
}
