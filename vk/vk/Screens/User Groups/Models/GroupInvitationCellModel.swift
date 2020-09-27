//
//  GroupInvitationCellModel.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

struct GroupInvitationCellModel {
    var eventImageUrl: URL?
    var invitorImageUrl: URL?
    
    var eventName: String
    var countOfParticipants: String
    var invitorName: String

    init(eventImage: String?, invitorImage: String?, eventName: String, countOfParticipants: String, invitorName: String) {
        eventImageUrl = URL(string: eventImage ?? "")
        invitorImageUrl = URL(string: invitorImage ?? "")
        
        self.eventName = eventName
        self.invitorName = invitorName
        self.countOfParticipants = countOfParticipants
    }
}

extension GroupInvitationCellModel {
    static var emptyState: GroupInvitationCellModel {
        return GroupInvitationCellModel(eventImage: "", invitorImage: "", eventName: "", countOfParticipants: "", invitorName: "")
    }
}
