//
//  Model.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 21.06.2023.
//

import Foundation

struct CharactersModel: Codable {
    let info: InfoCharacters
    let results: [ResultsCharacters]
}

struct InfoCharacters: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct ResultsCharacters: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: OriginCharacters
    let location: LocationCharacters
    let image: String
    let episode: [String]
    let url: String
}

struct OriginCharacters: Codable {
    let name: String
    let url: String
}

struct LocationCharacters: Codable {
    let name: String
    let url: String
}
