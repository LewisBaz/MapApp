//
//  MainViewController.swift
//  MapApp
//
//  Created by Lewis on 04.05.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let imageSaver = ImageSaverToFiles()
    
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
        UserDefaults.standard.removeObject(forKey: "UserLoginName")
        imageSaver.deleteImageFromDisk(fileName: Constants.savedAvatarImageFileNameString)
        router.toLaunch()
    }
}
