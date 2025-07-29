//
//  MainTabBarController.swift
//  RickAndMortyApp
//
//  Created by Rabia Çete on 29.07.2025.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

    private func setupTabs() {
        let charactersVC = CharactersViewController()
        charactersVC.title = "Characters"
        charactersVC.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person.3"), tag: 0)

        let episodesVC = EpisodesViewController()
        episodesVC.title = "Episodes"
        episodesVC.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "film"), tag: 1)

        let locationsVC = LocationsViewController()
        locationsVC.title = "Locations"
        locationsVC.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "map"), tag: 2)

        viewControllers = [charactersVC, episodesVC, locationsVC].map {
            UINavigationController(rootViewController: $0)
        }
    }
}
