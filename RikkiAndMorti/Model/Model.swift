//
//  Model.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 21.06.2023.
//

import Foundation

struct Model: Codable {
    let info: Info
    let results: [Results]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Results: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
}

struct Origin: Codable {
    let name: String
    let url: String
}

struct Location: Codable {
    let name: String
    let url: String
}
