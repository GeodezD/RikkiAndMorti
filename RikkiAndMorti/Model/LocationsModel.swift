//
//  LocationsModel.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 20.07.2023.
//

import Foundation

struct LocationsModel: Codable {
    let info: InfoLocations
    let results: [ResultsLocations]
}

struct InfoLocations: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct ResultsLocations: Codable {
    
}
