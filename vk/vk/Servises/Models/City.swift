//
//  City.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation
import RealmSwift

class City:  Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var title: String
}
