//
//  UserGroupInvitationModel.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation

struct UserGroupInvitationModel: Codable {
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

extension UserGroupInvitationModel {
    struct Event: Codable {
        
        enum Codingkeys: String, CodingKey {
            case id
            case isAdmin = "is_admin"
            case isAdvertiser = "is_advertiser"
            case isClosed = "is_closed"
            case isMember = "is_member"
            case name
            case screenName = "screen_name"
            case photo = "photo_200"
        }
        
        
        let id: Int
        
        let isAdmin: Int
        let isAdvertiser: Int
        let isClosed: Int
        let isMember: Int
        
        let name: String
        let screenName: String
        
        let photo: String?
        
    }
}

