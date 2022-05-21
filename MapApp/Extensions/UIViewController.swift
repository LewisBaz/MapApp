//
//  UIViewController.swift
//  MapApp
//
//  Created by Lewis on 02.05.2022.
//

import UIKit
import RxSwift
import RxCocoa

extension UIViewController {
    
    func presentAlertWithTitle(title: String, message: String, options: String..., completion: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(options[index])
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    func configureLoginBindings(loginTF: UITextField, passwordTF: UITextField, button: UIButton) {
        Observable
        .combineLatest(
            loginTF.rx.text,
            passwordTF.rx.text )
        .map { login, password in
            return !(login ?? "").isEmpty && (password ?? "").count >= 6 }
        .bind { [weak button] inputFilled in
            button?.isEnabled = inputFilled
        }
    }
}
