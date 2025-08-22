//
//  EpisodesViewController.swift
//  RickAndMortyApp
//
//  Created by Rabia Çete on 29.07.2025.
//


import UIKit

class EpisodesViewController: UITableViewController {

    var episodes: [Episode] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episodes"
        setupTableView()
        fetchEpisodes()
    }

    private func setupTableView() {
        //  identifier'ı sınıf isminden alıyoruz
        let identifier = String(describing: EpisodeCell.self)
        let nib = UINib(nibName: identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifier)
        tableView.rowHeight = 80
    }


    private func fetchEpisodes() {
        NetworkManager.shared.fetchData(from: "https://rickandmortyapi.com/api/episode", as: EpisodeResponse.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.episodes = response.results
                    self.tableView.reloadData()

                case .failure(let error):
                    print("Hata oluştu: \(error.localizedDescription)")
                }
            }
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath) as? EpisodeCell else {
            return UITableViewCell()
        }

        let episode = episodes[indexPath.row]
        cell.configure(with: episode)
        return cell
    }
}
