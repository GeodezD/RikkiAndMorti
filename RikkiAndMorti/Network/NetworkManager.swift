//
//  NetworkManager.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 21.06.2023.
//

import Foundation

enum FirstPageUrl: String {
    case characters = "https://rickandmortyapi.com/api/character/?page=1"
    case episodes = "https://rickandmortyapi.com/api/episode/?page=1"
    case locations = "https://rickandmortyapi.com/api/location/?page=1"
}

final class NetworkManager: NetworkDelegate {
    
    func fetchPage(str: String, completion: @escaping ((Data) -> Void)) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig,
                                 delegate: nil,
                                 delegateQueue: nil)
        guard let url = URL(string: str) else { fatalError() }
        var request = URLRequest(url: url,  cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
        request.httpMethod = "GET"
        let serialQueue = DispatchQueue(label: "Network", attributes: .concurrent)
        serialQueue.sync {
            let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                if error != nil {
                    print("error")
                }
                guard let data = data else { return }
                completion(data)
            }
            task.resume()
            session.finishTasksAndInvalidate()
        }
    }
    
    func decodeData<T: Decodable>(_ data: Data, into type: T.Type) -> T? {
        let decoder = JSONDecoder()
        do {
            if type is EpisodesModel.Type || type is ResultsEpisodes.Type {
                decoder.keyDecodingStrategy = .convertFromSnakeCase
            }
            let decodedData = try decoder.decode(type, from: data)
            switch type {
            case is CharactersModel.Type:
                UserDefaults.standard.set(data, forKey: "Characters")
            case is EpisodesModel.Type:
                UserDefaults.standard.set(data, forKey: "Episodes")
            case is LocationsModel.Type:
                UserDefaults.standard.set(data, forKey: "Locations")
            case is ResultsCharacters.Type:
                UserDefaults.standard.set(data, forKey: "Character")
            case is ResultsEpisodes.Type:
                UserDefaults.standard.set(data, forKey: "ResultsEpisodes")
            default:
                print("Fails")
                break
            }
            return decodedData
        } catch {
            print("Decoding error: \(error)")
            return nil
        }
    }
    
    func returnDataFromUserDafaults<T>(into type: T.Type) -> T? {
        var returnData: T?
        let decoder = JSONDecoder()
        switch type {
        case is CharactersModel.Type:
            
            let data = UserDefaults.standard.data(forKey: "Characters")
            do {
                guard let forceData = data else { fatalError("I'm don't have DATA") }
                returnData = try decoder.decode(CharactersModel.self, from: forceData) as? T
            } catch {
                print("error: ", error)
            }
            return returnData
            
        case is EpisodesModel.Type:
            
            let data = UserDefaults.standard.data(forKey: "Episodes")
            do {
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let forceData = data else { fatalError("I'm don't have DATA") }
                returnData = try decoder.decode(EpisodesModel.self, from: forceData) as? T
            } catch {
                print("error: ", error)
            }
            return returnData
            
        case is ResultsEpisodes.Type:
            
            let data = UserDefaults.standard.data(forKey: "ResultsEpisodes")
            do {
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let forceData = data else { fatalError("I'm don't have DATA") }
                returnData = try decoder.decode(ResultsEpisodes.self, from: forceData) as? T
            } catch {
                print("error: ", error)
            }
            return returnData
            
        case is LocationsModel.Type:
            
            let data = UserDefaults.standard.data(forKey: "Locations")
            do {
                guard let forceData = data else { fatalError("I'm don't have DATA") }
                returnData = try decoder.decode(LocationsModel.self, from: forceData) as? T
            } catch {
                print("error: ", error)
            }
            return returnData
            
        case is ResultsCharacters.Type:
            
            let data = UserDefaults.standard.data(forKey: "Character")
            do {
                guard let forceData = data else { fatalError("I'm don't have DATA") }
                returnData = try decoder.decode(ResultsCharacters.self, from: forceData) as? T
            } catch {
                print("error: ", error)
            }
            return returnData
            
        default:
            break
        }
        return returnData
    }
}

