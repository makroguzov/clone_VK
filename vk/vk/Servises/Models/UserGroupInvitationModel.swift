//
//  UserGroupInvitationModel.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation

struct UserGroupInvitationModel: Decodable {
    let response: Response
}

extension UserGroupInvitationModel {
    struct Response: Decodable {
        enum CodingKeys: String, CodingKey {
            case invitorGroups = "groups"
            case invitorUsers = "profiles"
            case events = "items"
            case count
        }

        let count: Int
        let invitorGroups: [GroupModel]
        let invitorUsers: [UserModel]
        let events: [Event]
        
    }
}

extension UserGroupInvitationModel {
    struct Event: Decodable {
        let id: Int
        
        let is_admin: Int
        let is_advertiser: Int
        let is_closed: Int
        let is_member: Int
        
        let name: String
        let screen_name: String
        
        let photo_200: String?

    }
}

