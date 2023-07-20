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
    case locations = "https://rickandmortyapi.com/api/location/?page=1b"
}

enum DecooderFromStruct {
    case charactersModel
    case episodesModel
    case locationsModel
}

class Memory: MemoryDelegate {
    
    private func decodeData(selectType: DecooderFromStruct) -> (CharactersModel?, EpisodesModel?, LocationsModel?) {
        var result: (CharactersModel?, EpisodesModel?, LocationsModel?)
        let data = UserDefaults.standard.data(forKey: "Data")
        switch selectType {
        case DecooderFromStruct.charactersModel:
            do {
                guard let forceData = data else { fatalError("I'm don't have DATA") }
                let characters = try JSONDecoder().decode(CharactersModel.self, from: forceData)
                result = (characters, nil, nil)
            } catch {
                print("error: ", error)
            }
        case DecooderFromStruct.episodesModel:
            do {
                guard let forceData = data else { fatalError("I'm don't have DATA") }
                let episodes = try JSONDecoder().decode(EpisodesModel.self, from: forceData)
                result = (nil, episodes, nil)
            } catch {
                print("error: ", error)
            }
        default:
            do {
                guard let forceData = data else { fatalError("I'm don't have DATA") }
                let locations = try JSONDecoder().decode(LocationsModel.self, from: forceData)
                result = (nil, nil, locations)
            } catch {
                print("error: ", error)
            }
        }
        return result
    }

    func receivingDataCharacters(_ str: String = FirstPageUrl.characters.rawValue) {
        NetworkManager().fetchPage(str: str)
    }
    
    func receivingataEpisodes(_ str: String = FirstPageUrl.episodes.rawValue) {
        NetworkManager().fetchPage(str: str)
    }
    
    func receivingDataLocations(_ str: String = FirstPageUrl.locations.rawValue) {
        NetworkManager().fetchPage(str: str)
    }
    
    func returnDataCharacters() -> CharactersModel {
//        decodeDataCharacters
        let characters = decodeData(selectType: DecooderFromStruct.charactersModel)
        guard let forceCharacters = characters.0 else{ fatalError("I have NIL")}
        return forceCharacters
    }
    
    func returnDataEpisodes() -> EpisodesModel {
//        decodeDataEpisodes
        let characters = decodeData(selectType: DecooderFromStruct.episodesModel)
        guard let forceCharacters = characters.1 else{ fatalError("I have NIL")}
        return forceCharacters
    }

    func returnDataLocations() -> LocationsModel {
//        decodeDataLocations
        let characters = decodeData(selectType: DecooderFromStruct.locationsModel)
        guard let forceCharacters = characters.2 else{ fatalError("I have NIL")}
        return forceCharacters
    }
    
}
