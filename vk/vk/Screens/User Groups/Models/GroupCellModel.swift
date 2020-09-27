//
//  GroupCellModel.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

struct GroupCellModel {
    var image: URL?
    var groupName: String
    var groupSubtitle: String

    init(image: String?, groupName: String, groupSubtitle: String) {
        self.image = URL(string: image ?? "")
        self.groupName = groupName
        self.groupSubtitle = groupSubtitle
    }
}

extension GroupCellModel {
    static var emptyState: GroupCellModel {
        return GroupCellModel(image: "", groupName: "", groupSubtitle: "")
    }
}
