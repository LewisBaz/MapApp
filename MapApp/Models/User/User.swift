//
//  User.swift
//  MapApp
//
//  Created by Lewis on 04.05.2022.
//

import Foundation
import RealmSwift

final class User: Object {
    @objc dynamic var login: String = ""
    @objc dynamic var password: String = ""
    
    convenience required init(login: String, password: String) {
        self.init()
        self.login = login
        self.password = password
    }
    
    override static func primaryKey() -> String? {
        return "login"
    }
}
