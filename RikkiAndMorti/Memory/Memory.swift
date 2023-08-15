////
////  Memory.swift
////  RikkiAndMorti
////
////  Created by Дмитро Сегейда on 20.07.2023.
////
//
//import UIKit
//
//final class Memory: MemoryDelegate {
//    
//    private var delegate: NetworkDelegate?
//    
//    func receivingDataCharacters(_ str: String = FirstPageUrl.characters.rawValue) {
//        delegate = NetworkManager()
//        delegate?.fetchPage(str: str) { data in
//            UserDefaults.standard.set(data, forKey: "Characters")
//        }
//    }
//    
//    func receivingDataEpisodes(_ str: String = FirstPageUrl.episodes.rawValue) {
//        delegate = NetworkManager()
//        delegate?.fetchPage(str: str) { data in
//            UserDefaults.standard.set(data, forKey: "Episodes")
//        }
//    }
//    
//    func receivingDataLocations(_ str: String = FirstPageUrl.locations.rawValue) {
//        delegate = NetworkManager()
//        delegate?.fetchPage(str: str) { data in
//            UserDefaults.standard.set(data, forKey: "Locations")
//        }
//    }
//    
//    func receivingDataCharacter(_ str: String) {
//        delegate = NetworkManager()
//        delegate?.fetchPage(str: str) { data in
//            UserDefaults.standard.set(data, forKey: "Character")
//        }
//    }
//    
//    func returnDataCharacters() -> CharactersModel {
//        var result: CharactersModel?
//        let data = UserDefaults.standard.data(forKey: "Characters")
//        do {
//            guard let forceData = data else { fatalError("I'm don't have DATA") }
//            result = try JSONDecoder().decode(CharactersModel.self, from: forceData)
//        } catch {
//            print("error: ", error)
//        }
//        guard let result = result else { fatalError("I'm don't have result") }
//        return result
//    }
//        
//    func returnDataEpisodes() -> EpisodesModel {
//        var result: EpisodesModel?
//        do {
//            let data = UserDefaults.standard.data(forKey: "Episodes")
//            guard let forceData = data else { fatalError("I'm don't have DATA") }
//            let decode = JSONDecoder()
//            decode.keyDecodingStrategy = .convertFromSnakeCase
//            result = try decode.decode(EpisodesModel.self, from: forceData)
//        } catch {
//            print("error: ", error)
//        }
//        guard let result = result else { fatalError("I'm don't have result") }
//        return result
//    }
//    
//    func returnDataLocations() -> LocationsModel {
//        var result: LocationsModel?
//        do {
//            let data = UserDefaults.standard.data(forKey: "Locations")
//            guard let forceData = data else { fatalError("I'm don't have DATA") }
//            result = try JSONDecoder().decode(LocationsModel.self, from: forceData)
//        } catch {
//            print("error: ", error)
//        }
//        guard let result = result else { fatalError("I'm don't have result") }
//        return result
//    }
//    
////    func returnDataCharacter() -> CharacterModel {
////        var result: CharacterModel?
////        do {
////            let data = UserDefaults.standard.data(forKey: "Character")
////            guard let forceData = data else { fatalError("I'm don't have DATA") }
////            result = try JSONDecoder().decode(CharacterModel.self, from: forceData)
////        } catch {
////            print("error: ", error)
////        }
////        guard let result = result else { fatalError("I'm don't have result") }
////        return result
////    }
//
//}
