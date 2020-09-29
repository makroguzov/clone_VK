//
//  PostCreatorInformationTableViewHeader.swift
//  vk
//
//  Created by MACUSER on 19.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class PostCreatorInfCell: UITableViewCell {
    static var identifier: String = "PostCreatorInfCell"
    
    @IBOutlet private weak var creatorImageView: UIImageView! {
        didSet {
            creatorImageView.layer.cornerRadius = creatorImageView.frame.width / 2
        }
    }
    @IBOutlet private weak var nameLable: UILabel!
    @IBOutlet private weak var subtitleLable: UILabel!
    
    @IBOutlet private weak var settingsButton: UIButton! {
        didSet {
            settingsButton.addTarget(self, action: #selector(settingsButtonAction(_:)), for: .touchUpInside)
        }
    }
    
    
    
    @objc private func settingsButtonAction(_ sender: UIButton) {
        
    }
}
