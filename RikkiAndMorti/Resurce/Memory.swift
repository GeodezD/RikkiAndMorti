//
//  Memory.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 13.07.2023.
//

import Foundation

class Memory {
    private var data: Model?
    private var startUrl = "https://rickandmortyapi.com/api/character/?page=1"
    
    func exportData(completion: @escaping ((Model?) -> Void)) {
        completion(data)
    }
    
    func importData()  {
        NetworkManager().fetchPage(str: startUrl) { model in
            self.data = model
            print("fetchData END")
        }
    }
    
}
