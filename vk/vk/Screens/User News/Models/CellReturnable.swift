//
//  CellReturnable.swift
//  vk
//
//  Created by Валерий Макрогузов on 29.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

protocol CellReturnable {
    var identifier: String { get set }
    var height: CGFloat { get set }
    
    func getCell(_ tableView: UITableView, by: Int) -> UITableViewCell
}
