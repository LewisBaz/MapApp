//
//  MainViewController.swift
//  MapApp
//
//  Created by Lewis on 04.05.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet weak var router: MainRouter!
    
    @IBAction func goToMapTapped(_ sender: Any) {
        router.toMap()
    }
    
    @IBAction func onLogOutTapped(_ sender: Any) {
        router.toLaunch()
    }
}
