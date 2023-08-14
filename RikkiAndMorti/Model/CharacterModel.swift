//
//  CharacterModel.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 04.08.2023.
//

import Foundation

//struct CharacterModel: Codable {
//    let info: InfoCharacters
//    let results: [ResultsCharacters]
//}

struct CharacterModel: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: OriginCharacter
    let location: LocationCharacter
    let image: String
    let episode: [String]
    let url: String
}

struct OriginCharacter: Codable {
    let name: String
    let url: String
}

struct LocationCharacter: Codable {
    let name: String
    let url: String
}


