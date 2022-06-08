//
//  TabBarController.swift
//  MapApp
//
//  Created by Lewis on 29.05.2022.
//

import UIKit

final class TabBarController: UITabBarController {
    
    @IBOutlet weak var router: TabBarRouter!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createNavigationProfileButton()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadController), name: NSNotification.Name("ProfileControllerMadeNewImage"), object: nil)
    }
    
    private func createNavigationProfileButton() {
        let button = ProfileBarButtonItem()
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(customView: button)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openProfile)))
    }
    
    @objc private func openProfile() {
        router.toProfile()
    }
    
    @objc private func reloadController() {
        createNavigationProfileButton()
    }
}
