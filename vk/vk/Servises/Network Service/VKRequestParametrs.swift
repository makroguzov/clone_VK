//
//  VKRequestParametrs.swift
//  vk
//
//  Created by MACUSER on 20.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation
import Alamofire

struct VKRequestParametrs {

    enum LoadDataType: String {
        case friends = "/method/friends.get"
        case newsfeed = "/method/newsfeed.get"
    }

    let baseUrl: String = "https://api.vk.com"
    var path: LoadDataType
    
    var params: Parameters = [:]
}


