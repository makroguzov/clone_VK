//
//  PostBottomButtonsTableViewFooter.swift
//  vk
//
//  Created by MACUSER on 20.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class PostBottomButtonsCell: UITableViewCell {
    static let identifier: String = "PostBottomButtonsCell"
    
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var sharedButton: UIButton!
    @IBOutlet private weak var commentButton: UIButton!
    
    @IBOutlet private weak var likeLable: UILabel!
    @IBOutlet private weak var sharedLable: UILabel!
    @IBOutlet private weak var commentLable: UILabel!
}
