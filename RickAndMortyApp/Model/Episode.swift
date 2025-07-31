//
//  Episode.swift
//  RickAndMortyApp
//
//  Created by Rabia Çete on 30.07.2025.
//

import Foundation

struct EpisodeResponse: Codable {
    let results: [Episode]
}

struct Episode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
}
