//
//  FriendsCellModel.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit
import SDWebImage

struct FriendsCellModel {
    var imageUrl: URL?
    var name: String
    var subtitle: String

    private var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        df.timeZone = TimeZone(secondsFromGMT: 0)
        
        return df
    }()

    
    init(image: String?, name: String, surename: String, bdate: String?, city: UserModel.City?) {
        self.imageUrl = URL(string: image ?? "")
        self.name = "\(name) \(surename)"
        self.subtitle = "\(bdate ?? "")"
    }
}



extension FriendsCellModel {
    static var emptyState: FriendsCellModel {
        return FriendsCellModel(image: "", name: "", surename: "", bdate: "", city: nil)
    }
}
