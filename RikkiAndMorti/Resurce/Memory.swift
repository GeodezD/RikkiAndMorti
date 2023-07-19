//
//  Memory.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 13.07.2023.
//

import UIKit
enum FirstPageUrl: String {
    case url = "https://rickandmortyapi.com/api/character/?page=1"
}

class Memory {
    private var data: Model?
    private var fetchData: Model {
        var result: Model?
        let data = UserDefaults.standard.data(forKey: "Data")
        do {
            guard let forceData = data else { fatalError("I'm don't have DATA") }
            result = try JSONDecoder().decode(Model.self, from: forceData)
        } catch {
            print("error: ", error)
        }
        guard let result = result else { fatalError("I'm don't have result") }
        return result
    }
    
    func exportFetchData() -> Model {
        fetchData
    }
    
    func importData(_ newUrl: String = FirstPageUrl.url.rawValue)  {
        NetworkManager().fetchPage(str: newUrl) { [weak self] model in
            guard let self = self else { return }
            self.data = model
        }
    }
}
