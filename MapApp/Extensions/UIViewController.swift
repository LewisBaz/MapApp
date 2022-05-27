//
//  UIViewController.swift
//  MapApp
//
//  Created by Lewis on 02.05.2022.
//

import UIKit

extension UIViewController {
    
    func presentAlertWithTitle(title: String, message: String, options: String..., completion: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(options[index])
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
