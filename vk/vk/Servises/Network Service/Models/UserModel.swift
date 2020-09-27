//
//  UserModel.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation
import RealmSwift

class UserModel: Object, Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case deactivated
        case bdate
        case city
        case photo100 = "photo_100"
        case photo200 = "photo_200"
        case photo50 = "photo_50"
        case photoOrig = "photo_200_orig"
    }

    @objc dynamic var id: Int = 0

    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""

    let canAccessClosed = RealmOptional<Bool>()
    let isClosed = RealmOptional<Bool>()

    @objc dynamic var deactivated: String?

    @objc dynamic var bdate: String?
    @objc dynamic var city: City?

    @objc dynamic var photo100: String?
    @objc dynamic var photo200: String?
    @objc dynamic var photo50: String?
    @objc dynamic var photoOrig: String?
    
    
    @objc dynamic var name: String {
        return "\(firstName) \(lastName)"
    }
    
    
    override class func ignoredProperties() -> [String] {
        ["name"]
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
}
