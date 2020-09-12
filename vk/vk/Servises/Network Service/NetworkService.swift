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
    
    enum Request {
        case friends(withParams: FriendsParametrs)
    }

    func load(_ request: Request, complition: @escaping ( (Any) -> Void )) {
        
        switch request {
        case let .friends(withParams: params):
            getUserFriends(with: params, complition: complition)
        }
    }

    func loadUserGroupInvitations(offset: Int, count: Int, extended: Int, complitoin: @escaping (UserGroupInvitationModel) -> Void) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/groups.getInvites"
    
        let params: Parameters = [
            "access_token": Session.shared.token,
            "extended": extended,
            "offset" : offset,
            "count" : count,
            "v": "5.92"
        ]
    
        session.request(baseUrl + path, method: .get, parameters: params).responseDecodable { (response: DataResponse<UserGroupInvitationModel, AFError>) in
            switch response.result {
                case .success(let userGroupInvitationModel):
                    complitoin(userGroupInvitationModel)
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
    
    func loadUserGroups(userId: String, extended: Int, filter: String, fields: String, offset: Int, count: Int, complitoin: @escaping (UserGroupsModel) -> Void) {
    let baseUrl = "https://api.vk.com"
    let path = "/method/groups.get"
    
    let params: Parameters = [
        "access_token": Session.shared.token,
        "user_id" : userId,
        "extended": extended,
        "filter" : filter,
        "fields" : fields,
        "offset" : offset,
        "count" : count,
        "v": "5.92"
    ]

    session.request(baseUrl + path, method: .get, parameters: params).responseDecodable { (response: DataResponse<UserGroupsModel, AFError>) in
        switch response.result {
        case .success(let userGroupModel):
            complitoin(userGroupModel)
        case .failure(let err):
            print(err.localizedDescription)
        }
    }
    
}
        
    private func getUserFriends(with params: FriendsParametrs, complition: @escaping (UserFriendsModel) -> Void) {
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
