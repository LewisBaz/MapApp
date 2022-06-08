//
//  LocationService.swift
//  MapApp
//
//  Created by Lewis on 22.05.2022.
//

import Foundation
import CoreLocation
import RxSwift
import RxRelay

final class LocationManager: NSObject {
    
    static let instance = LocationManager()
    private let locationManager = CLLocationManager()
    private let geoCoder = CLGeocoder()
    private let locationsDatabaseService = MarkedLocationsDatabaseService()
    
    let location: BehaviorRelay<CLLocation?> = BehaviorRelay(value: nil)
    
    private override init() {
        super.init()
        configureLocationManager()
    }
    
    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.requestAlwaysAuthorization()
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startMonitoringVisits()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location.accept(locations.last)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        let location = CLLocation(latitude: visit.coordinate.latitude, longitude: visit.coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location) { placemarks, error in
            if let place = placemarks?.first {
                let description = "\(place)"
                self.newVisitReceived(visit, description: description)
              }
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func newVisitReceived(_ visit: CLVisit, description: String) {
        let location = Location(visit: visit, descriptionString: description)
        locationsDatabaseService.saveLocation(location)
        
        let notificationsFactory = NotificationsFactory(locationDescription: description)
        let notification = notificationsFactory.createNotification(essense: .notificationOnRecievingVisit)
        notification.sendNotificatioRequest(content: notification.makeNotificationContent(),
                                            trigger: notification.makeIntervalNotificatioTrigger())
    }
}
