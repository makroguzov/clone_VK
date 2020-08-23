//
//  UserModel.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation
import RealmSwift

class UserModel: Object, Decodable {
    @objc dynamic var id: Int

    @objc dynamic var first_name: String
    @objc dynamic var last_name: String

    let  can_access_closed = RealmOptional<Bool>()
    let  is_closed = RealmOptional<Bool>()

    @objc dynamic var deactivated: String?

    @objc dynamic var bdate: String?
    @objc dynamic var city: City?

    @objc dynamic var photo_100: String?
    @objc dynamic var photo_200: String?
    @objc dynamic var photo_50: String?
    @objc dynamic var photo_200_orig: String?
}

//struct UserModel: Decodable {
//    let id: Int
//
//    let first_name: String
//    let last_name: String
//
//    var can_access_closed: Bool?
//    var is_closed: Bool?
//
//    var deactivated: String?
//
//    var bdate: String?
//    var city: City?
//
//    var photo_100: String?
//    var photo_200: String?
//    var photo_50: String?
//    var photo_200_orig: String?
//}
//
//extension UserModel {
//    struct City: Decodable {
//        let id: Int
//        let title: String
//    }
//}
