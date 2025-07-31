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
        let nib = UINib(nibName: "EpisodeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EpisodeCell")
        tableView.rowHeight = 80
    }

    private func fetchEpisodes() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/episode") else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let decoded = try? JSONDecoder().decode(EpisodeResponse.self, from: data) else { return }

            DispatchQueue.main.async {
                self.episodes = decoded.results
                self.tableView.reloadData()
            }
        }.resume()
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
