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

    
    let session: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        let session = Alamofire.Session(configuration: configuration)
        return session
    }()
    
    
    enum Request: Any {
        case getUserFriends(withParams: FriendsParametrs)
        case getUserGroups(withParams: GropsRequestParams)
    }
    

    func load(_ request: Request, complition: @escaping ( (Any) -> Void )) {
        switch request {
        case let .getUserFriends(withParams: params):
            loadData(with: params, complition: complition)
        case let .getUserGroups(withParams: params):
            loadData(with: params, complition: complition)
        }
    }
        
    private func loadData<T: RequestParametrizable>(with params: T, complition: @escaping (Any) -> Void) {
        session.request(params.baseUrl + params.path, method: .get, parameters: params.params).responseDecodable() {
            (response: DataResponse<Response<UserFriendsModel>, AFError>) in
            
            switch response.result {
            case .success(let result):
                return complition(result.response)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }    
}
