//
//  Location.swift
//  MapApp
//
//  Created by Lewis on 28.05.2022.
//

import Foundation
import CoreLocation
import RealmSwift

final class Location: Object {
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var date: Date = Date()
    @objc dynamic var descriptionString: String = ""
    
    convenience required init(visit: CLVisit, descriptionString: String) {
        self.init()
        self.latitude = visit.coordinate.latitude
        self.longitude = visit.coordinate.longitude
        self.date = visit.departureDate
        self.descriptionString = descriptionString
    }
}
