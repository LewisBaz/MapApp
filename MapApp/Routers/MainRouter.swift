//
//  MainRouter.swift
//  MapApp
//
//  Created by Lewis on 04.05.2022.
//

import UIKit

final class MainRouter: BaseRouter {
    
    func toMap() {
        let controller = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(MapViewController.self)
        show(controller)
    }
    
    func toLaunch() {
        let controller = UIStoryboard(name: "Auth", bundle: nil)
            .instantiateViewController(AuthViewController.self)
        setAsRoot(UINavigationController(rootViewController: controller))
    }
}
