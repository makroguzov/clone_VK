//
//  Response.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation

class Response<T: Codable>: Codable {
    let response: T
}
