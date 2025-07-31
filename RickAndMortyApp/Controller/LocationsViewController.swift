//
//  LocationsViewController.swift
//  RickAndMortyApp
//
//  Created by Rabia Çete on 29.07.2025.
//

import UIKit

class LocationsViewController: UITableViewController {

    var locations: [LocationItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Locations"
        setupTableView()
        fetchLocations()
    }

    private func setupTableView() {
        let nib = UINib(nibName: "LocationCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "LocationCell")
        tableView.rowHeight = 80
    }

    private func fetchLocations() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/location") else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let decoded = try? JSONDecoder().decode(LocationResponse.self, from: data) else { return }

            DispatchQueue.main.async {
                self.locations = decoded.results
                self.tableView.reloadData()
            }
        }.resume()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as? LocationCell else {
            return UITableViewCell()
        }

        let location = locations[indexPath.row]
        cell.configure(with: location)
        return cell
    }
    
    
    // MARK: - Section Header (Name - Type - Dimension)
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.systemGray6

        let nameLabel = UILabel()
        nameLabel.text = "Name"
        nameLabel.font = .boldSystemFont(ofSize: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        let typeLabel = UILabel()
        typeLabel.text = "Type"
        typeLabel.font = .boldSystemFont(ofSize: 16)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false

        let dimensionLabel = UILabel()
        dimensionLabel.text = "Dimension"
        dimensionLabel.font = .boldSystemFont(ofSize: 16)
        dimensionLabel.translatesAutoresizingMaskIntoConstraints = false

        headerView.addSubview(nameLabel)
        headerView.addSubview(typeLabel)
        headerView.addSubview(dimensionLabel)

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),

            typeLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            typeLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),

            dimensionLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            dimensionLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])

        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    
}
