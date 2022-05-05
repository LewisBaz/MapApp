//
//  UserLoginDatabaseService.swift
//  MapApp
//
//  Created by Lewis on 05.05.2022.
//

import Foundation
import RealmSwift

final class UserLoginDatabaseService: BaseRealmDatabase {
    
    func addUser(_ user: User) {
        do {
            realm.beginWrite()
            realm.add(user)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func checkUser(_ user: User) -> Bool {
        let savedUser = realm.object(ofType: User.self, forPrimaryKey: user.login)
        guard let savedUser = savedUser else {
            return false
        }
        
        if savedUser.password == user.password {
            return true
        } else {
            changeUserPassword(user: savedUser, newPassword: user.password)
            return true
        }
    }
    
    func changeUserPassword(user: User, newPassword: String) {
        do {
            realm.beginWrite()
            user.password = newPassword
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
