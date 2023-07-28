//
//  NetworkManager.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 21.06.2023.
//

import Foundation

final class NetworkManager: NetworkDelegate {
    
    init() {
        print("Network ON")
    }
    var target = false
    func fetchPage(str: String,  completion: @escaping ((Data) -> Void)) {
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
                print("I'm save DATA")
                completion(data)
            }
            task.resume()
            session.finishTasksAndInvalidate()
        }
    }
    
    deinit {
        print("Network OFF")
    }
}
