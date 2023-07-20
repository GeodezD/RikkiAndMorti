//
//  EpisodesModel.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 20.07.2023.
//

import Foundation

struct EpisodesModel: Codable {
    let info: InfoEpisodes
    let results: [ResultsEpisodes]
}

struct InfoEpisodes: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct ResultsEpisodes: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
