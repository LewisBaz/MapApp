//
//  BaseRealmDatabase.swift
//  MapApp
//
//  Created by Lewis on 05.05.2022.
//

import Foundation
import RealmSwift

class BaseRealmDatabase {
    
    var config = Realm.Configuration(schemaVersion: 1)
    lazy var realm = try! Realm(configuration: config)
    
    public func getRealmFileURL() {
        print(realm.configuration.fileURL as Any)
    }
}
