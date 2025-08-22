//
//  CharactersViewController.swift
//  RickAndMortyApp
//
//  Created by Rabia Çete on 29.07.2025.
//

import UIKit

final class CharactersViewController: UITableViewController {

    // Tüm karakterler burada tutulur
    var characters: [Character] = []

    // Filtrelenmiş karakterler burada tutulur (TableView artık bunu kullanır)
    var filteredCharacters: [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rick & Morty"
        setupTableView()
        fetchAllCharacters() // Tüm karakterleri API'den çek
    }

    // TableView ayarları + filtreleme segmentini kurar
    private func setupTableView() {
        let nib = UINib(nibName: String(describing: CharacterCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: CharacterCell.self))
        tableView.rowHeight = 80


        // Üstteki filtreleme segmenti (All / Alive / Dead / Unknown)
        let items = ["All", "Alive", "Dead", "Unknown"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0 // Başlangıçta All seçili
        segmentedControl.addTarget(self, action: #selector(filterChanged(_:)), for: .valueChanged)
        navigationItem.titleView = segmentedControl
    }

    // Segment seçimi değiştiğinde tetiklenir
    @objc private func filterChanged(_ sender: UISegmentedControl) {
        let status = sender.titleForSegment(at: sender.selectedSegmentIndex)

        if status == "All" {
            filteredCharacters = characters
        } else {
            // Status büyük/küçük harf farkına takılmamak için hepsi lowercased
            filteredCharacters = characters.filter { $0.status.lowercased() == status?.lowercased() }
        }

        tableView.reloadData()
    }

    // API'den tüm karakterleri çeker
    private func fetchAllCharacters() {
        characters = []
        fetchPage(from: "https://rickandmortyapi.com/api/character")
    }

    // Sayfa sayfa karakter verilerini çeker
    private func fetchPage(from urlString: String) {
        NetworkManager.shared.fetchData(from: urlString, as: CharacterResponse.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.characters += response.results
                    self.filteredCharacters = self.characters
                    self.tableView.reloadData()

                    // Devam sayfası varsa tekrar çağır
                    if let next = response.info.next {
                        self.fetchPage(from: next)
                    }

                case .failure(let error):
                    print("Hata oluştu: \(error.localizedDescription)")
                }
            }
        }

    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = filteredCharacters[indexPath.row]
        let detailVC = CharacterDetailViewController(nibName: "CharacterDetailViewController", bundle: nil)
        detailVC.character = character
        navigationController?.pushViewController(detailVC, animated: true)
    }

    
    
    // MARK: - TableView Data Source

    // TableView satır sayısını filtrelenmiş karakterlere göre belirler
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCharacters.count
    }

    // Hücreye ilgili karakteri göndererek yapılandırır
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Daha güvenli: identifier'ı doğrudan sınıf isminden alıyoruz
        let identifier = String(describing: CharacterCell.self)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CharacterCell else {
            return UITableViewCell()
        }

        let character = filteredCharacters[indexPath.row]
        cell.configure(with: character)
        return cell
    }

}


