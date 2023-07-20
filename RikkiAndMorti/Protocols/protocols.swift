//
//  protocols.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 20.07.2023.
//

import UIKit

protocol MemoryDelegate {
    func receivingDataCharacters(_ str: String)
    func receivingataEpisodes(_ str: String)
    func receivingDataLocations(_ str: String)
    func returnDataCharacters() -> CharactersModel
    func returnDataEpisodes() -> EpisodesModel
    func returnDataLocations() -> LocationsModel
    
}
