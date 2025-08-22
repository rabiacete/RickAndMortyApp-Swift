//
//  Location.swift
//  RickAndMortyApp
//
//  Created by Rabia Çete on 30.07.2025.
//

import Foundation

struct LocationResponse: Decodable {
    let results: [LocationItem]
}

struct LocationItem: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
}
