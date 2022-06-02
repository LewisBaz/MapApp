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
