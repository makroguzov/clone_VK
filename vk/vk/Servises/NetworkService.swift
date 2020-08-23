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

    
    static let session: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        let session = Alamofire.Session(configuration: configuration)
        return session
    }()
    
//    func loadUserInfo(user_ids: String, fields: String, name_case: String, closure: @escaping ([UserModel]) -> Void) {
//        let baseUrl = "https://api.vk.com"
//        let path = "/method/users.get"
//
//        let params: Parameters = [
//            "access_token": Session.shared.token,
//            "user_ids": user_ids,
//            "fields": fields,
//            "name_case" : name_case,
//            "v": "5.92"
//        ]
//
//        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { (response) in
//            guard let json = response.value else { return }
//            let  response = (json as! [String: Any])["response"] as! [Any]
//
//            //let users = response.map { UserModel(json: $0 as! [String: Any]) }
//            //closure(users)
//        }
//    }

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
    
        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseDecodable { (response: DataResponse<UserGroupInvitationModel, AFError>) in
            switch response.result {
                case .success(let userGroupInvitationModel):
                    complitoin(userGroupInvitationModel)
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
    
    func loadUserGroups(userId: String, extended: Int, filter: String, fields: String, offset: Int, count: Int,
     complitoin: @escaping (UserGroupsModel) -> Void) {
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

        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseDecodable { (response: DataResponse<UserGroupsModel, AFError>) in
            switch response.result {
            case .success(let userGroupModel):
                complitoin(userGroupModel)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        
    }
    
    func loadUserFriends(user_id: String, order: String, list_id: String, count: Int, offset: Int, fields: String, name_case: String, ref: String, complition: @escaping (UserFriendsModel) -> Void) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/friends.get"
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "user_id": user_id,
            "order": order,
            "list_id": list_id,
            "count": count,
            "offset": offset,
            "fields": fields,
            "name_case": name_case,
            "ref": ref,
            "v": "5.92"
        ]

        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseDecodable() {
            (response: DataResponse<UserFriendsModel, AFError>) in
            
            switch response.result {
            case .success(let userFriendsModel):
                complition(userFriendsModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
