//
//  PostCreatorInfCellModel.swift
//  vk
//
//  Created by MACUSER on 20.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit
import SDWebImage

struct PostCreatorInfCellModel: CellReturnable {
    
    private var image: String
    private var name: String
    private var subtitile: String
    
    
    var height: CGFloat
    
    
    func getCell(_ tableView: UITableView, by: Int) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCreatorInfCell.identifier) as? PostCreatorInfCell else {
            print("")
            fatalError()
        }
        
        cell.setParams(image: image, name: name, subtitle: subtitile)
        return cell
    }
}
