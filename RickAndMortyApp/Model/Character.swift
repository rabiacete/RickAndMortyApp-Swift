//
//  Character.swift
//  RickAndMortyApp
//
//  Created by Rabia Çete on 29.07.2025.
//

import Foundation

struct CharacterResponse: Codable {
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let next: String?
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let image: String
}
