//
//  CharactersInEpisode.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 30.08.2023.
//

import UIKit

class CharactersInEpisode:  ViewControllerWithCollectionView {
    
    var indexPathCelltable: Int?
    var arrayCharactersData = [ResultsCharacters?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAcitivityIndikator()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let data: EpisodesModel? = NetworkManager().returnDataFromUserDafaults(into: EpisodesModel.self)
        if let data, let indexPathCelltable {
            for url in data.results[indexPathCelltable].characters {
                let decodedPerson = takeData(url, type: ResultsCharacters.self)
                self.arrayCharactersData.append(decodedPerson)
            }
            semaphore.signal()
        }
        semaphore.wait()
        stopAcitivityIndikator()
    }

override func setup() {
    super.setup()
    collectionView.delegate = self
    collectionView.dataSource = self
    
    navigation.rightBarButtonItem = nil
    navigationTitle(title: "Characters in episode:")
}

override func prevPage() {
    navigationController?.popViewController(animated: true)
}



}
