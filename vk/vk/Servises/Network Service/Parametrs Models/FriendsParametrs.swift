//
//  FriendsParametrs.swift
//  vk
//
//  Created by MACUSER on 12.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Alamofire

struct FriendsParametrs: RequestParametrizable {
    var path = "/method/friends.get"
    var params: Parameters

    init(order: String = "", list_id: String = "", count: Int, offset: Int = 0, fields: String = "", name_case: String = "", ref: String = "") {
        
        params = [
            "access_token": Session.shared.token,
            "user_id": Session.shared.userId,
            "order": order,
            "list_id": list_id,
            "count": count,
            "offset": offset,
            "fields": fields,
            "name_case": name_case,
            "ref": ref,
            "v": "5.92"
        ]
    }
}
