//
//  File.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 29.06.2023.
//

import UIKit

class Api {
    var urlAll = "https://rickandmortyapi.com/api/character/?page="
    
    func nextUrl(url: String) {
        urlAll = url
    }
}
