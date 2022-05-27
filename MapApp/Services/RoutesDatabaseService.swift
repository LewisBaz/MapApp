//
//  RoutesDatabaseService.swift
//  MapApp
//
//  Created by Lewis on 02.05.2022.
//

import Foundation
import RealmSwift

final class RoutesDatabaseService: BaseRealmDatabase {
    
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
