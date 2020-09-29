//
//  Repost.swift
//  vk
//
//  Created by Валерий Макрогузов on 26.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation

struct Repost: Codable {
    enum CodingKeys: String, CodingKey {
        case count
        case isUserReposted = "user_reposted" 
    }
    
    let count: Int
    let isUserReposted: Int
}
