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
    @IBOutlet weak var iventImageView: UIImageView! {
        didSet {
            iventImageView.layer.cornerRadius = iventImageView.frame.width / 2
        }
    }
    @IBOutlet weak var iventorImageView: UIImageView! {
        didSet {
            iventorImageView.layer.cornerRadius = iventorImageView.frame.width / 2
        }
    }
    @IBOutlet weak var acceptButton: UIButton! {
        didSet {
            acceptButton.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var rejectButton: UIButton! {
        didSet {
            rejectButton.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var iventNameLable: UILabel!
    @IBOutlet weak var countOfParticipantsLable: UILabel!
    @IBOutlet weak var iventorNameLable: UILabel!
    
    var model: GroupInvitationCellModel = .emptyState {
        didSet {
            iventImageView.sd_setImage(with: model.eventImageUrl, completed: nil)
            iventorImageView.sd_setImage(with: model.invitorImageUrl, completed: nil)
            
            iventNameLable.text = model.eventName
            countOfParticipantsLable.text = String(model.countOfParticipants)
            iventorNameLable.text = model.invitorName
        }
    }
}
