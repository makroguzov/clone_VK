//
//  FriendsViewModel.swift
//  vk
//
//  Created by Валерий Макрогузов on 29.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit
import RealmSwift

class FriendsViewModel {
    
    enum Sections: Int {
        case requestForFirens
        case mostImportantfriends
        case friends
    }
    
    
    private let realmService = RealmService.shared
 
    
    private var friendCellModelsNotificationToken: NotificationToken?
    private var mostImportantFriendCellModelsNotificationToken: NotificationToken?
    
    
    private var mostImportantFriendCellModels: Results<UserFriendModel>? {
        return realmService?.getObjects()
    }
    private var friendCellModels: Results<UserFriendModel>? {
        return realmService?.getObjects().sorted(byKeyPath: "id")
    }
    private var filteredFriendCellModels: Results<UserFriendModel>?


    
}
