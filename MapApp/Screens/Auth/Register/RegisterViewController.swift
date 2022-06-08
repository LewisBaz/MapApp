//
//  RegisterViewController.swift
//  MapApp
//
//  Created by Lewis on 04.05.2022.
//

import UIKit

final class RegisterViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var router: LoginRouter!
    
    private let databaseService = UserLoginDatabaseService()
    private let userDefaultsStandart = UserDefaults.standard
    
    override func viewDidLoad() {
        setupTextFields()
        configureLoginBindings(loginTF: loginTextField, passwordTF: passwordTextField, button: registerButton)
    }
    
    private func setupTextFields() {
        loginTextField.autocorrectionType = .no
        passwordTextField.autocorrectionType = .no
    }
    
    @IBAction func onRegisterTapped(_ sender: Any) {
        if loginTextField.hasText && passwordTextField.hasText {
            guard let login = loginTextField.text,
                  let password = passwordTextField.text else { return }
            databaseService.addUser(User(login: login, password: password))
            userDefaultsStandart.set(true, forKey: "isLogin")
            userDefaultsStandart.set(login, forKey: "UserLoginName")
            router.toMain()
        }
    }
}
