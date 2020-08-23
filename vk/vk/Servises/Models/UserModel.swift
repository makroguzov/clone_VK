//
//  UserModel.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation

struct UserModel: Decodable {
    let id: Int

    let first_name: String
    let last_name: String
    
    var can_access_closed: Bool?
    var is_closed: Bool?

    var deactivated: String?

    var bdate: String?
    var city: City?

    var photo_100: String?
    var photo_200: String?
    var photo_50: String?
    var photo_200_orig: String?
}

extension UserModel {
    struct City: Decodable {
        let id: Int
        let title: String
    }
}
