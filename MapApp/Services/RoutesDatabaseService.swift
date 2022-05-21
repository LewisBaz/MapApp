//
//  RoutesDatabaseService.swift
//  MapApp
//
//  Created by Lewis on 02.05.2022.
//

import Foundation
import RealmSwift

final class RoutesDatabaseService {
    
    var config = Realm.Configuration(schemaVersion: 0)
    lazy var realm = try! Realm(configuration: config)
    
    func addRoute(route: RealmRoute) {
        do {
            realm.beginWrite()
            realm.add(route)
            try realm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func recieveRoute() -> RealmRoute {
        return realm.objects(RealmRoute.self).last ?? RealmRoute(decodedRoute: "")
    }
}
