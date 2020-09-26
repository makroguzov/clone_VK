//
//  NetworkService.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    static var shared = NetworkService()
    private init() {}
    
    
    private let session: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        let session = Alamofire.Session(configuration: configuration)
        return session
    }()
    
    
    func loadData<T: Codable>(with params: VKRequestParametrs, complition: @escaping (T) -> Void) {
        session.request(params.baseUrl + params.path.rawValue, method: .get, parameters: params.params).responseDecodable() {
            (response: DataResponse<Response<T>, AFError>) in
            
            switch response.result {
            case .success(let result):
                return complition(result.response)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }    
}
