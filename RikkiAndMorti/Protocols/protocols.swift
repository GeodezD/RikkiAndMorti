//
//  protocols.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 20.07.2023.
//

import UIKit

protocol MemoryDelegate: AnyObject {
    func receivingDataCharacters(_ str: String)
    func receivingDataEpisodes(_ str: String)
    func receivingDataLocations(_ str: String)
    func returnDataCharacters() -> CharactersModel
    func returnDataEpisodes() -> EpisodesModel
    func returnDataLocations() -> LocationsModel
}

protocol NetworkDelegate {
    func fetchPage(str: String, completion: @escaping ((Data) -> Void))
}

protocol ActivityIndikatorDelegate {
    func setupView() -> UIView
    func indikator() -> UIActivityIndicatorView
}
