//
//  AuthViewController.swift
//  MapApp
//
//  Created by Lewis on 04.05.2022.
//

import UIKit

final class AuthViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var router: LoginRouter!
    
    private let databaseService = UserLoginDatabaseService()
    
    @IBAction func onRegisterTapped(_ sender: Any) {
        router.toRegister()
    }
    
    @IBAction func onEnterTapped(_ sender: Any) {
        if loginTextField.hasText && passwordTextField.hasText {
            guard let login = loginTextField.text,
                  let password = passwordTextField.text else { return }
            let isRegistered = databaseService.checkUser(User(login: login, password: password))
            if isRegistered {
                router.toMain()
            } else {
                presentAlertWithTitle(title: "Wrong login or password", message: "Please, try again or register if you haven't done it yet", options: "OK", completion: { [weak self] _ in
                    guard let self = self else { return }
                    self.passwordTextField.text = ""
                    self.loginTextField.text = ""
                })
            }
        }
    }
}
