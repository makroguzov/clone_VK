//
//  RequestParametrizable.swift
//  vk
//
//  Created by MACUSER on 12.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestParametrizable {
    var baseUrl: String { get }
    var path: String { get }
    
    var params: Parameters { get set }
}

extension RequestParametrizable {
    var baseUrl: String {
        return "https://api.vk.com"
    }
}
