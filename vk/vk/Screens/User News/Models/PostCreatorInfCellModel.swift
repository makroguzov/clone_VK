//
//  PostCreatorInfCellModel.swift
//  vk
//
//  Created by MACUSER on 20.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

struct PostCreatorInfCellModel: CellReturnable {
    
    var height: CGFloat
    var identifier: String

    func getCell(_ tableView: UITableView, by: Int) -> UITableViewCell {
        return UITableViewCell()
    }
}
