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
    
    override func viewDidLoad() {
        setupTextFields()
        configureLoginBindings(loginTF: loginTextField, passwordTF: passwordTextField, button: registerButton)
    }
    
    private func setupTextFields() {
        loginTextField.autocorrectionType = .no
        passwordTextField.autocorrectionType = .no
    }
    
    private let databaseService = UserLoginDatabaseService()
    
    @IBAction func onRegisterTapped(_ sender: Any) {
        if loginTextField.hasText && passwordTextField.hasText {
            guard let login = loginTextField.text,
                  let password = passwordTextField.text else { return }
            databaseService.addUser(User(login: login, password: password))
            UserDefaults.standard.set(true, forKey: "isLogin")
            router.toMain()
        }
    }
}
