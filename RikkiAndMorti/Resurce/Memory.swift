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
    
//    func exportData(completion: @escaping ((Model?) -> Void)) {
//        completion(data)
//    }
    
    func exportData() -> Model? {
        return data
    }
    
    func editStartUrl(newUrl: String) {
        print("Take new url:", newUrl)
        importData(newUrl)
    }
    
    func importData(_ newUrl: String = FirstPageUrl.url.rawValue)  {
        NetworkManager().fetchPage(str: newUrl) { [weak self] model in
            guard let self = self else { return }
            self.data = model
        }
    }
    
    func printData() {
        print(data?.info.next)
    }
    
}
