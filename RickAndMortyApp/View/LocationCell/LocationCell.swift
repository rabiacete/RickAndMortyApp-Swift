//
//  LocationCell.swift
//  RickAndMortyApp
//
//  Created by Rabia Çete on 31.07.2025.
//

import UIKit

class LocationCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dimensionLabel: UILabel!

    func configure(with location: LocationItem) {
        nameLabel.text = location.name
        typeLabel.text = location.type
        dimensionLabel.text = location.dimension
    }
}
