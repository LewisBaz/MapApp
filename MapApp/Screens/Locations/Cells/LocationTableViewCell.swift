//
//  LocationTableViewCell.swift
//  MapApp
//
//  Created by Lewis on 29.05.2022.
//

import UIKit

final class LocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var adressLabel: UILabel!
    
    func configure(location: Location) {
        adressLabel.text = location.descriptionString
        selectionStyle = .none
    }
}
