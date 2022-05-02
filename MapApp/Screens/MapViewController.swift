//
//  ViewController.swift
//  MapApp
//
//  Created by Lewis on 02.05.2022.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    
    var locationManager: CLLocationManager?
    private let geocoder = CLGeocoder()
    
    let coordinatesSPB = CLLocationCoordinate2D(latitude: 59.9386300, longitude: 30.3141300)
    let coordinatesMoscow = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
        configureLocationManager()
    }
    
    private func configureMap() {
        mapView.delegate = self
        let camera = GMSCameraPosition(target: coordinatesSPB, zoom: 15)
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    private func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
    }
    
    private func addMarker(coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        marker.map = mapView
    }
    
    @IBAction func toCityAction(_ sender: Any) {
        locationManager?.stopUpdatingLocation()
        mapView.animate(toLocation: coordinatesMoscow)
    }
}

extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print(coordinate)
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        locationManager?.startUpdatingLocation()
        return true
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let coordinate = locations.last?.coordinate else { return }
        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))
        addMarker(coordinate: coordinate)

        
        guard let location = locations.last else { return }
        geocoder.reverseGeocodeLocation(location) { places, error in
            print(places?.first as Any)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
