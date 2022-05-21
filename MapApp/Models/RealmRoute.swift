//
//  RealmRoute.swift
//  MapApp
//
//  Created by Lewis on 02.05.2022.
//

import Foundation
import RealmSwift

class RealmRoute: Object {
    @objc dynamic var decodedRoute: String = ""
    
    convenience required init(decodedRoute: String) {
        self.init()
        self.decodedRoute = decodedRoute
    }
}
