//
//  CharacterDetailViewController.swift
//  RickAndMortyApp
//
//  Created by Rabia Çete on 30.07.2025.
//


import UIKit

final class CharacterDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var speciesLabel: UILabel!
    @IBOutlet private weak var originLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!

    // MARK: - Veriyi dışarıdan alacağız
    var character: Character!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = character.name
        configureUI()
    }

    private func configureUI() {
        nameLabel.text = character.name
        statusLabel.text = "Status: \(character.status)"
        speciesLabel.text = "Species: \(character.species)"
        originLabel.text = "Origin: \(character.origin.name)"
        locationLabel.text = "Location: \(character.location.name)"

        if let url = URL(string: character.image) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
}
