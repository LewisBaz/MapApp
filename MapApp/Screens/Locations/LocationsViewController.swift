//
//  LocationsViewController.swift
//  MapApp
//
//  Created by Lewis on 29.05.2022.
//

import UIKit
import RealmSwift

final class LocationsViewController: UITableViewController {
    
    private let locationsDatabaseService = MarkedLocationsDatabaseService()
    
    var locations: Results<Location>? = nil {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        locations = getLocationResults()
    }
    
    private func getLocationResults() -> Results<Location> {
        return locationsDatabaseService.recieveLocations()
    }
    
    private func configureTableView() {
        navigationController?.navigationBar.topItem?.title = "Recent locations"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as! LocationTableViewCell
        guard let locations = locations else { return UITableViewCell() }
        cell.configure(location: locations[indexPath.row])
        return cell
    }
    
}
