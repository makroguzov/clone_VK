//
//  GroupHeader.swift
//  vk
//
//  Created by MACUSER on 24.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

extension GroupHeader {
    
    enum Models {
        case mostImportantFriendsSection
        case friendsSection(FriendsSection)
        case firstSection
    }
    
    struct FriendsSection {
        var friendsAmount: Int
    }
}

class GroupHeader: UITableViewHeaderFooterView {
    
    var model: Models? {
        didSet {
            cleanHeader()
            
            switch model {
            case .firstSection:
                createFirstSectionContent()
            case .mostImportantFriendsSection:
                createMostImportantFriendsSectionContent()
            case .friendsSection(let data):
                createFriendsSectionContent(friendsSectionData: data)
            default:
                return
            }
        }
    }
    
    private let borderIndent: CGFloat = 15
    
    private func createFirstSectionContent() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        stackView.contentMode = .scaleToFill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackViewConstraints = [
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: borderIndent),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -borderIndent),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ]
        
            
        let scanCodeButton = UIButton()
        scanCodeButton.setTitle("Сканировать QR", for: .normal)
        scanCodeButton.setTitleColor(.white, for: .normal)
        scanCodeButton.backgroundColor = .systemBlue
        scanCodeButton.layer.cornerRadius = 10
        scanCodeButton.translatesAutoresizingMaskIntoConstraints = false
        
        let addFriendButton = UIButton()
        addFriendButton.setTitle("Добавить друга", for: .normal)
        addFriendButton.setTitleColor(.white, for: .normal)
        addFriendButton.backgroundColor = .systemBlue
        addFriendButton.layer.cornerRadius = 10
        addFriendButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        stackView.addArrangedSubview(scanCodeButton)
        stackView.addArrangedSubview(addFriendButton)
                    
        contentView.addSubview(stackView)
        addConstraints(stackViewConstraints)
    }
    
    private func createMostImportantFriendsSectionContent() {
        let textLable = UILabel()
        textLable.translatesAutoresizingMaskIntoConstraints = false
        
        textLable.text = "Важные"
        textLable.font = UIFont(name: "RobotoSlab-Medium", size: 16)
        
        let lableConstraints = [
            textLable.leftAnchor.constraint(equalTo: leftAnchor, constant: borderIndent),
            textLable.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            textLable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            textLable.rightAnchor.constraint(equalTo: rightAnchor, constant: -borderIndent)
        ]
        
        contentView.addSubview(textLable)
        addConstraints(lableConstraints)
        
        drawSeparator(rect: CGRect(x: borderIndent, y: 5, width: frame.width - 5, height: 2))
    }
    
    private func createFriendsSectionContent(friendsSectionData: FriendsSection) {
        let textLable = UILabel()
        textLable.translatesAutoresizingMaskIntoConstraints = false
        
        
        let lableText = NSMutableAttributedString()
        let textName = NSAttributedString(string: "Мои Друзья ", attributes:
            [
                NSAttributedString.Key.font: UIFont(name: "RobotoSlab-Medium", size: 16)!,
                NSAttributedString.Key.foregroundColor: UIColor.black
        ])
        lableText.append(textName)
        
        let friendsAmountText = NSAttributedString(string: String(friendsSectionData.friendsAmount), attributes:
            [
                NSAttributedString.Key.font: UIFont(name: "RobotoSlab-Light", size: 12)!,
                NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ])
        lableText.append(friendsAmountText)
        
        textLable.attributedText = lableText
        
        
        
        let lableConstraints = [
            textLable.leftAnchor.constraint(equalTo: leftAnchor, constant: borderIndent),
            textLable.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            textLable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            textLable.rightAnchor.constraint(equalTo: rightAnchor, constant: -borderIndent)
        ]
        
        contentView.addSubview(textLable)
        addConstraints(lableConstraints)
        
        drawSeparator(rect: CGRect(x: borderIndent, y: 5, width: frame.width - 5, height: 2))
    }
    
    private func cleanHeader() {
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
    }
    
    private func drawSeparator(rect: CGRect) {
        let separatorView = UIView()
        separatorView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: 5)
        
        let separator = UIBezierPath()
        
        separator.move(to: CGPoint(x: rect.minX, y: rect.minY))
        separator.addLine(to: CGPoint(x: rect.width - rect.minX, y: rect.minY))
        separator.lineWidth = rect.width
        separator.close()
        
        let layer = CAShapeLayer()
        layer.path = separator.cgPath
        layer.strokeColor = UIColor.lightGray.cgColor

        separatorView.layer.addSublayer(layer)
        
        contentView.addSubview(separatorView)
    }
}

//extension GroupFirstSectionHeader {
//
//    private var filteredGroups = [Group]()
//
//
//    private var searschBarIsEmpty: Bool {
//            guard let text = searchController.searchBar.text else { return false }
//            return text.isEmpty
//        }
//
//    private var isSearchStarted: Bool {
//            return searchController.isActive && !searschBarIsEmpty
//        }
//
//    private lazy var searchController: UISearchController = {
//            let serchController = UISearchController(searchResultsController: nil)
//
//            serchController.searchResultsUpdater = self
//            serchController.obscuresBackgroundDuringPresentation = false
//            serchController.searchBar.placeholder = "поиск"
//
//            return serchController
//        }()
//        override func viewDidLoad() {
//            super.viewDidLoad()
//
//            navigationItem.searchController = searchController
//            definesPresentationContext = true
//
//    }
//
//extension MyGroupsViewController: UISearchResultsUpdating {
//        func updateSearchResults(for searchController: UISearchController) {
//            filterContentForSearchText(searchController.searchBar.text!)
//        }
//
//        private func filterContentForSearchText(_ searchText: String) {
//            filteredGroups = groupsData.filter({ (group: Group) -> Bool in
//                return group.groupName.lowercased().contains(searchText.lowercased())
//            })
//
//            tableView.reloadData()
//        }
//    }
//
//}
