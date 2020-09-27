//
//  GroupInvitationCell.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit
import SDWebImage

class GroupInvitationCell: UITableViewCell {
    
    @IBOutlet private weak var eventImageView: UIImageView! {
        didSet {
            eventImageView.layer.cornerRadius = eventImageView.frame.width / 2
        }
    }
    @IBOutlet private weak var invitorImageView: UIImageView! {
        didSet {
            invitorImageView.layer.cornerRadius = invitorImageView.frame.width / 2
        }
    }
    
    @IBOutlet private weak var acceptButton: UIButton! {
        didSet {
            acceptButton.layer.cornerRadius = 10
        }
    }
    @IBOutlet private weak var rejectButton: UIButton! {
        didSet {
            rejectButton.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet private weak var eventNameLable: UILabel!
    @IBOutlet private weak var countOfParticipantsLable: UILabel!
    @IBOutlet private weak var invitorNameLable: UILabel!
    
    static let identifier = "GroupInvitationCell"
    static let heigth: CGFloat = 100

    var model: GroupInvitationCellModel = .emptyState {
        didSet {
            eventImageView.sd_setImage(with: model.eventImageUrl, completed: nil)
            invitorImageView.sd_setImage(with: model.invitorImageUrl, completed: nil)
            
            eventNameLable.text = model.eventName
            countOfParticipantsLable.text = String(model.countOfParticipants)
            invitorNameLable.text = model.invitorName
        }
    }
}
