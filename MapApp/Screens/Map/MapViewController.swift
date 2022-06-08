//
//  ViewController.swift
//  MapApp
//
//  Created by Lewis on 02.05.2022.
//

import UIKit
import GoogleMaps
import CoreLocation
import RealmSwift

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var router: MapRouter!
    
    let locationManager = LocationManager.instance
    private let geocoder = CLGeocoder()
    private let databaseService = RoutesDatabaseService()
    var route: GMSPolyline?
    var routePath: GMSMutablePath?
    var currentRoute: GMSPolyline?
    var currentRoutePath: GMSMutablePath?
    var isRoutingNow = false
    
    let coordinatesSPB = CLLocationCoordinate2D(latitude: 59.9386300, longitude: 30.3141300)
    let coordinatesMoscow = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
        configureLocationManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureController()
    }
    
    private func configureController() {
        navigationController?.navigationBar.topItem?.title = nil
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func configureMap() {
        mapView.delegate = self
        let camera = GMSCameraPosition(target: coordinatesSPB, zoom: 15)
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    private func addMarker(coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        marker.map = mapView
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        router.toMain()
    }
    
    @IBAction func startRouteAction(_ sender: Any) {
        isRoutingNow = true
        currentRoute?.map = nil
        currentRoute = GMSPolyline()
        currentRoute?.strokeColor = .systemGreen
        currentRoute?.strokeWidth = 3
        currentRoutePath = GMSMutablePath()
        currentRoute?.map = mapView
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func stopRouteAction(_ sender: Any) {
        isRoutingNow = false
        let finishedPath = RealmRoute(decodedRoute: currentRoutePath?.encodedPath() ?? "")
        saveLastRoute(route: finishedPath)
        locationManager.stopUpdatingLocation()
    }
    
    @IBAction func showLastRoute(_ sender: Any) {
        if isRoutingNow {
            let alertAssistant = AlertControllerAssistant(title: "You are routing now!",
                                                          message: "If you want to see last route, we need to finish current route",
                                                          options: ["OK", "Cancel"],
                                                          caller: self)
            alertAssistant.presentAlertWithTitle(completion: { [weak self] option in
                guard let self = self else { return }
                switch option {
                case "OK":
                    self.isRoutingNow = false
                    self.locationManager.stopUpdatingLocation()
                    self.makeLastRoute()
                default:
                    break
                }
            })
        } else {
            locationManager.stopUpdatingLocation()
            makeLastRoute()
        }
    }
    
    private func configureLocationManager() {
        locationManager
            .location
            .asObservable()
            .bind { [weak self] location in
                guard let location = location,
                      let self = self else { return }
                if self.isRoutingNow {
                    self.currentRoutePath?.add(location.coordinate)
                    self.currentRoute?.path = self.currentRoutePath
                }
                
                self.mapView.animate(toLocation: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
                //addMarker(coordinate: location.coordinate)

                self.geocoder.reverseGeocodeLocation(location) { places, error in
                    print(places?.first as Any)
                }
            }
    }
    
    private func makeLastRoute() {
        route?.map = nil
        route = GMSPolyline()
        route?.strokeColor = .systemRed
        route?.strokeWidth = 3
        routePath = GMSMutablePath(fromEncodedPath: recieveLastRoute().decodedRoute)
        route?.path = routePath
        route?.map = mapView
        if let max = routePath?.count() {
            let middle: UInt = max / 2
            guard let routePath = routePath else { return }
            mapView.animate(toLocation: CLLocationCoordinate2D(latitude: routePath.coordinate(at: middle).latitude, longitude: routePath.coordinate(at: middle).longitude))
        }
    }
    
    private func saveLastRoute(route: RealmRoute) {
        databaseService.addRoute(route: route)
    }
    
    private func recieveLastRoute() -> RealmRoute {
        return databaseService.recieveRoute()
    }
}

extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print(coordinate)
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        locationManager.requestLocation()
        return true
    }
}
