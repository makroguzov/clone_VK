//
//  UserFriendsModel.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation
import RealmSwift

struct UserFriendsModel: Codable {
    enum CodingKeys: String, CodingKey {
        case friends = "items"
        case count
    }

    var count: Int = 0
    var friends: [UserFriendModel]
}

