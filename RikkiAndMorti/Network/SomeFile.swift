//
//  SomeFile.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 29.06.2023.
//

import UIKit

class SomeFile {
    var page = 10
    var urlAll = "https://rickandmortyapi.com/api/character/?page="
    var string = "https://rickandmortyapi.com/api/character/?page="
    
    func nextPage() -> String {
        return urlAll + "\(page)"
    }
}
