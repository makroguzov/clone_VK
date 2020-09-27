//
//  Geo.swift
//  vk
//
//  Created by Валерий Макрогузов on 26.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation

struct Geo: Codable {
    enum CodingKeys: String, CodingKey {
        case placeId = "place_id"
        case title
        case type
        case countryId = "country_id"
        case cityId = "city_id"
        case address
    }
    
    let placeId: Int
    let title: String
    let type: String
    let countryId: Int
    let cityId: Int
    let address: String

}
