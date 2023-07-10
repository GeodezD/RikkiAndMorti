//
//  NetworkManager.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 21.06.2023.
//

import Foundation



//enum Api: String {
//    case url = "https://rickandmortyapi.com/api/character/?page="
//    case urlPage = "https://rickandmortyapi.com/api/character/"
//}



class NetworkManager {
    var page = 1
    var string = "https://rickandmortyapi.com/api/character/?page="
    
    var urlAll: String { return string + "\(page)" }
    
    func fetchPage(str: String, completion: @escaping ((Model) -> Void)) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig,
                                 delegate: nil,
                                 delegateQueue: nil)
        guard let url = URL(string: str) else { return }
        var request = URLRequest(url: url,  cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("error")
            }
            guard let data = data else { return }
            do {
                let decoderJSON = try JSONDecoder().decode(Model.self, from: data)
                completion(decoderJSON)
                print("Data")
            } catch {
                print("error: ", error)
            }
        }
        task.resume()
        session.finishTasksAndInvalidate()
        print("Network")
    }
}
