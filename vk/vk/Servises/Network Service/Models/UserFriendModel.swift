//
//  UserFriendModel.swift
//  vk
//
//  Created by MACUSER on 03.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import RealmSwift

class UserFriendModel: Object, Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo200 = "photo_200"
        case bdate
        case city
    }

    @objc dynamic var id: Int = 0

    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""

    @objc dynamic var photo200: String?

    @objc dynamic var bdate: String?
    @objc dynamic var city: City?

    override class func primaryKey() -> String? {
        "id"
    }
}
