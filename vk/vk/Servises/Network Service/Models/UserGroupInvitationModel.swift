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
    var invitorGroups: [GroupModel]
    var invitorUsers: [Profile]
    var events: [Event]
}

extension UserGroupInvitationModel {
    struct Event: Codable {
        
        enum Codingkeys: String, CodingKey {
            case id
            case invitedBy = "invited_by"
            case isAdmin = "is_admin"
            case isAdvertiser = "is_advertiser"
            case isClosed = "is_closed"
            case isMember = "is_member"
            case name
            case screenName = "screen_name"
            case photo = "photo_100"
        }
        
        let id: Int
        
        let invitedBy: Int
        
        let isAdmin: Int
        let isAdvertiser: Int
        let isClosed: Bool
        let isMember: Int
        
        let name: String
        let screenName: String
        
        let photo: String
    }

    struct Profile: Codable {
        
        enum CodingKeys: String, CodingKey {
            case id
            case firstName = "first_name"
            case lastName = "last_name"
        }
        
        let id: Int
        let firstName: String
        let lastName: String
    }
}

