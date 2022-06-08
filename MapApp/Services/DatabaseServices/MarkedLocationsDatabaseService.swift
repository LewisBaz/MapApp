//
//  MarkedLocationsDatabaseService.swift
//  MapApp
//
//  Created by Lewis on 03.06.2022.
//

import Foundation
import Realm
import RealmSwift

final class MarkedLocationsDatabaseService: BaseRealmDatabase {
    
    func saveLocation(_ location: Location) {
        do {
            realm.beginWrite()
            realm.add(location)
            try realm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func recieveLocations() -> Results<Location> {
        return realm.objects(Location.self)
    }
}
