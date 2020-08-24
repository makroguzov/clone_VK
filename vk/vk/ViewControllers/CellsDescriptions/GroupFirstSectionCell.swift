//
//  GroupFirstSectionCell.swift
//  vk
//
//  Created by MACUSER on 24.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class GroupFirstSectionCell: UITableViewCell {
    @IBOutlet weak var firstImageView: UIImageView! {
        didSet {
            firstImageView.layer.cornerRadius = firstImageView.frame.width / 2
            firstImageView.layer.borderColor = UIColor.white.cgColor
            firstImageView.layer.borderWidth = 2
            firstImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var secondImageView: UIImageView! {
        didSet {
            secondImageView.layer.cornerRadius = secondImageView.frame.width / 2
            secondImageView.layer.borderColor = UIColor.white.cgColor
            secondImageView.layer.borderWidth = 2
            secondImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var thirdImageView: UIImageView! {
        didSet {
            thirdImageView.layer.cornerRadius = thirdImageView.frame.width / 2
            thirdImageView.layer.borderColor = UIColor.white.cgColor
            thirdImageView.layer.borderWidth = 2
            thirdImageView.clipsToBounds = true
        }
    }
    
    private lazy var customAccessoryView: UIButton = {
        let image = UIImage(systemName: "message", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)

        let button = UIButton()
        button.setImage(image, for: .normal)
        //button.addTarget(self, action: #selector(messageButtonAction(_:)), for: .touchUpInside)
        
        button.sizeToFit()
        return button
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()

        //accessoryView = customAccessoryView
    }
}
