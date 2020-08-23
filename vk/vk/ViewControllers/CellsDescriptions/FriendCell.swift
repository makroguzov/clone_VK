//
//  FriendCell.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit
import SDWebImage

class FriendCell: UITableViewCell {
    @IBOutlet weak var friendImage: UIImageView! {
        didSet {
            friendImage.layer.cornerRadius = friendImage.frame.width / 2
        }
    }
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendSubtitile: UILabel!
    @IBOutlet weak var stackView: UIStackView! {
        didSet {
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            let constraints = [
                stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
                stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ]
            
            addConstraints(constraints)
        }
    }
    
    lazy var customAccessoryView: UIButton = {
        let image = UIImage(systemName: "message", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)

        let button = UIButton()
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(messageButtonAction(_:)), for: .touchUpInside)
        
        button.sizeToFit()
        return button
    }()
    
    var model: FriendsCellModel = .emptyState {
        didSet {
            friendImage.sd_setImage(with: model.imageUrl, completed: nil)
            friendName.text = model.name
            friendSubtitile.text = model.subtitle
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        accessoryView = customAccessoryView
    }
    
    @objc private func messageButtonAction(_ sender: UIButton) {
        print("ok")
    }
}
