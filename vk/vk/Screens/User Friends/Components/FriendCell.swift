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
    @IBOutlet weak var friendName: UILabel! {
        didSet {
            friendName.font = UIFont(name: "RobotoSlab-VariableFont_wght", size: 20)
        }
    }
    @IBOutlet weak var friendSubtitile: UILabel! {
        didSet {
            friendSubtitile.font = UIFont(name: "RobotoSlab-Light", size: 12)
        }
    }
    
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
    
    
    private var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        df.timeZone = TimeZone(secondsFromGMT: 0)
        
        return df
    }()
    
    
    var model: UserModel? {
        didSet {
            setFriendCellModel()
        }
    }
    
    private func setFriendCellModel() {
        guard let model = model else { return }
        
        if let imgStr = model.photo200, let imgUrl = URL(string: imgStr) {
            friendImage.sd_setImage(with: imgUrl, completed: nil)
        } else {
            friendImage.image = UIImage(named: "deactivated")
        }
        
        friendName.text = "\(model.firstName) \(model.lastName)"
        friendName.font = UIFont(name: "RobotoSlab-VariableFont_wght", size: 16)
        
        
        var friendSubtitileText = ""
        
        if let bdate = model.bdate, let date = dateFormatter.date(from: bdate), let days = Calendar.current.dateComponents([.day], from: date, to: Date()).day {
            let age = Int(days / 365)
            friendSubtitileText.append("\(String(age)), ")
        }
        if let city = model.city {
            friendSubtitileText.append(city.title)
        }
        
        friendSubtitile.text = friendSubtitileText
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        accessoryView = customAccessoryView
    }
    
    @objc private func messageButtonAction(_ sender: UIButton) {
        print("ok")
    }
}
