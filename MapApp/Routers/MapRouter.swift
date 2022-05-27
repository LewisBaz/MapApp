//
//  MapRouter.swift
//  MapApp
//
//  Created by Lewis on 05.05.2022.
//

import UIKit

final class MapRouter: BaseRouter {
    
    func toMain() {
        let controller = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(MainViewController.self)
        setAsRoot(UINavigationController(rootViewController: controller))
    }
}
