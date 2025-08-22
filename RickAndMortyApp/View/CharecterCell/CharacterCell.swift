//
//  CharacterCell.swift
//  RickAndMortyApp
//
//  Created by Rabia Çete on 29.07.2025.
//

import UIKit

class CharacterCell: UITableViewCell {


    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        characterImageView.layer.cornerRadius = 8
        characterImageView.clipsToBounds = true

    }

    func configure(with character: Character) {
        nameLabel.text = character.name
        
        // Resmi URL'den yükle
        if let url = URL(string: character.image) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self.characterImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
}
