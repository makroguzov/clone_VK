//
//  GetGropsRequest.swift
//  vk
//
//  Created by MACUSER on 12.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Alamofire

struct GropsRequestParams: RequestParametrizable {
    var path = "/method/groups.get"
    var params: Parameters
    
    init(userId: String = Session.shared.userId, extended: Int, filter: String, fields: String, offset: Int, count: Int) {
         
        params = [
            "access_token": Session.shared.token,
            "user_id" : userId,
            "extended": extended,
            "filter" : filter,
            "fields" : fields,
            "offset" : offset,
            "count" : count,
            "v": "5.92"
        ]
    }
}
