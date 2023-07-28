//
//  Memory.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 20.07.2023.
//

import UIKit

enum FirstPageUrl: String {
    
    case characters = "https://rickandmortyapi.com/api/character/?page=1"
    case episodes = "https://rickandmortyapi.com/api/episode/?page=1"
    case locations = "https://rickandmortyapi.com/api/location/?page=1"
}

final class Memory: MemoryDelegate {
    private var delegate: NetworkDelegate?
    
    func receivingDataCharacters(_ str: String = FirstPageUrl.characters.rawValue) {
        delegate = NetworkManager()
        delegate?.fetchPage(str: str) { data in
            UserDefaults.standard.set(data, forKey: "Data")
        }
    }
    
    func receivingDataEpisodes(_ str: String = FirstPageUrl.episodes.rawValue) {
        delegate = NetworkManager()
        delegate?.fetchPage(str: str) { data in
            UserDefaults.standard.set(data, forKey: "Data")
        }
    }
    
    func receivingDataLocations(_ str: String = FirstPageUrl.locations.rawValue) {
        delegate = NetworkManager()
        delegate?.fetchPage(str: str) { data in
            UserDefaults.standard.set(data, forKey: "Data")
        }
    }
    
    func returnDataCharacters() -> CharactersModel {
        var result: CharactersModel?
        let data = UserDefaults.standard.data(forKey: "Data")
        do {
            guard let forceData = data else { fatalError("I'm don't have DATA") }
            result = try JSONDecoder().decode(CharactersModel.self, from: forceData)
        } catch {
            print("error: ", error)
        }
        guard let result = result else { fatalError("I'm don't have result") }
        return result
    }
        
    func returnDataEpisodes() -> EpisodesModel {
        var result: EpisodesModel?
        do {
            let data = UserDefaults.standard.data(forKey: "Data")
            guard let forceData = data else { fatalError("I'm don't have DATA") }
            let decode = JSONDecoder()
            decode.keyDecodingStrategy = .convertFromSnakeCase
            result = try decode.decode(EpisodesModel.self, from: forceData)
        } catch {
            print("error: ", error)
        }
        guard let result = result else { fatalError("I'm don't have result") }
        return result
    }
    
    func returnDataLocations() -> LocationsModel {
        var result: LocationsModel?
        do {
            let data = UserDefaults.standard.data(forKey: "Data")
            guard let forceData = data else { fatalError("I'm don't have DATA") }
            result = try JSONDecoder().decode(LocationsModel.self, from: forceData)
        } catch {
            print("error: ", error)
        }
        guard let result = result else { fatalError("I'm don't have result") }
        return result
    }

}
