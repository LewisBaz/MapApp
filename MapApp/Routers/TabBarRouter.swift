//
//  TabBarRouter.swift
//  MapApp
//
//  Created by Lewis on 03.06.2022.
//

import UIKit

final class TabBarRouter: BaseRouter {
    
    func toProfile() {
        let controller = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(ProfileViewController.self)
        present(UINavigationController(rootViewController: controller))
    }
}
