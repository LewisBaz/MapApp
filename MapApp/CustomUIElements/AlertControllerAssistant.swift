//
//  AlertControllerAssistant.swift
//  MapApp
//
//  Created by Lewis on 28.05.2022.
//

import UIKit

struct AlertControllerAssistant {
    
    var title: String = ""
    var message: String = ""
    var options: [String] = []
    var caller: UIViewController?
    
    func presentAlertWithTitle(completion: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for option in options {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(option)
            }))
        }
        guard let caller = caller else { return }
        caller.present(alertController, animated: true, completion: nil)
    }
}
