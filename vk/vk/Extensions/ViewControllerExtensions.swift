//
//  ViewControllerExtensions.swift
//  vk
//
//  Created by MACUSER on 07.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String? = nil,
                           message: String? = nil,
                           handler: ((UIAlertAction) -> ())? = nil,
                           completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: completion)
    }
}
