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
            case id = "id"
            case invitedBy = "invited_by"
            case name = "name"
            case screenName = "screen_name"
            case photo = "photo_100"
        }
        
        let id: Int
        let invitedBy: Int?
        let name: String
        let screenName: String?
        let photo: String?
        
        
//        init(from decoder: Decoder) throws {
//
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//
//            do {
//                self.id = try container.decode(Int.self, forKey: .id)
//            } catch {
//                id = -1
//                print("problems with decoding id")
//            }
//
//            do {
//                self.invitedBy = try container.decode(Int.self, forKey: .invitedBy)
//            } catch {
//                invitedBy = -1
//                print("problems with decoding \(Codingkeys.invitedBy)")
//            }
//
//            do {
//                self.name = try container.decode(String.self, forKey: .name)
//            } catch {
//                name = ""
//                print("problems with decoding name")
//            }
//
//            do {
//                self.screenName = try container.decode(String.self, forKey: .screenName)
//            } catch {
//                screenName = ""
//                print("problems with decoding \(Codingkeys.screenName)")
//            }
//
//            do {
//                self.photo = try container.decode(String.self, forKey: .photo)
//            } catch {
//                photo = ""
//                print("problems with decoding \(Codingkeys.photo)")
//            }
//        }
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

