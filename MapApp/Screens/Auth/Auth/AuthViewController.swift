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
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var router: LoginRouter!
    
    private let databaseService = UserLoginDatabaseService()
    
    override func viewDidLoad() {
        setupTextFields()
        configureLoginBindings(loginTF: loginTextField, passwordTF: passwordTextField, button: loginButton)
    }
    
    private func setupTextFields() {
        loginTextField.autocorrectionType = .no
        passwordTextField.autocorrectionType = .no
    }
    
    @IBAction func onRegisterTapped(_ sender: Any) {
        router.toRegister()
    }
    
    @IBAction func onEnterTapped(_ sender: Any) {
        if loginTextField.hasText && passwordTextField.hasText {
            guard let login = loginTextField.text,
                  let password = passwordTextField.text else { return }
            let isRegistered = databaseService.checkUser(User(login: login, password: password))
            if isRegistered {
                UserDefaults.standard.set(isRegistered, forKey: "isLogin")
                router.toMain()
            } else {
                let alertAssistant = AlertControllerAssistant(title: "Wrong login or password",
                                                              message: "Please, try again or register if you haven't done it yet",
                                                              options: ["OK"],
                                                              caller: self)
                alertAssistant.presentAlertWithTitle(completion: { [weak self] _ in
                    guard let self = self else { return }
                    self.passwordTextField.text = ""
                    self.loginTextField.text = ""
                })
            }
        }
    }
}
