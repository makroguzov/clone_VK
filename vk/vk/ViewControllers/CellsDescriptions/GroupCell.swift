//
//  GroupCell.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit
import SDWebImage

class GroupCell: UITableViewCell {
    @IBOutlet weak var groupImageView: UIImageView! {
        didSet {
            groupImageView.layer.cornerRadius = groupImageView.frame.width / 2
        }
    }
    @IBOutlet weak var groupNameLable: UILabel!
    @IBOutlet weak var groupSubTitleLable: UILabel!
    
    var model: GroupCellModel = .emptyState {
        didSet{
            groupImageView.sd_setImage(with: model.image, completed: nil)
            groupNameLable.text = model.groupName
            groupSubTitleLable.text = model.groupSubtitle
        }
    }
}
