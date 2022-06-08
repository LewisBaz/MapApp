//
//  MainViewController.swift
//  MapApp
//
//  Created by Lewis on 04.05.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet weak var router: MainRouter!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureController()
    }
    
    private func configureController() {
        navigationController?.navigationBar.topItem?.title = "Map"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func goToMapTapped(_ sender: Any) {
        router.toMap()
    }
    
    @IBAction func onLogOutTapped(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLogin")
        router.toLaunch()
    }
}
