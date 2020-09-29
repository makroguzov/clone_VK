//
//  Creator.swift
//  vk
//
//  Created by Валерий Макрогузов on 29.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation

struct Creator {
    var name: String
    var subtitle: String
    var photo: String?
    
    init() {
        name = ""
        subtitle = ""
        photo = ""
    }
    
    mutating func setParams(name: String, subtitle: String, photo: String?) {
        self.name = name
        self.photo = photo
        self.subtitle = subtitle
    }
}
