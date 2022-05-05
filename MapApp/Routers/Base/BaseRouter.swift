//
//  BaseRouter.swift
//  MapApp
//
//  Created by Lewis on 04.05.2022.
//

import UIKit

class BaseRouter: NSObject {
    
    @IBOutlet weak var controller: UIViewController!
    
    func show(_ controller: UIViewController) {
        self.controller.show(controller, sender: nil)
    }
    
    func present(_ controller: UIViewController) {
        self.controller.present(controller, animated: true)
    }
    
    func setAsRoot(_ controller: UIViewController) {
        let keyWindow = Array(UIApplication.shared.connectedScenes)
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first(where: { $0.isKeyWindow })
        keyWindow?.rootViewController = controller
    }
}
