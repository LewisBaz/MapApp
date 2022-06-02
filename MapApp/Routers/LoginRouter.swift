//
//  LoginRouter.swift
//  MapApp
//
//  Created by Lewis on 04.05.2022.
//

import UIKit

final class LoginRouter: BaseRouter {
    
    func toMain() {
        let controller = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(TabBarController.self)
        setAsRoot(UINavigationController(rootViewController: controller))
    }
    
    func toRegister() {
        let controller = UIStoryboard(name: "Auth", bundle: nil)
            .instantiateViewController(RegisterViewController.self)
        show(controller)
    }
}
