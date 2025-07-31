//
//  EpisodeCell.swift
//  RickAndMortyApp
//
//  Created by Rabia Çete on 31.07.2025.
//
import UIKit

class EpisodeCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var airDateLabel: UILabel!

    func configure(with episode: Episode) {
        nameLabel.text = episode.name
        episodeLabel.text = episode.episode
        airDateLabel.text = episode.air_date
    }
}
