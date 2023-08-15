//
//  EpisodeViewCell + extension.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 03.08.2023.
//

import UIKit

extension EpisodeViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let networkManager = NetworkManager()
        if let data: EpisodesModel = networkManager.returnDataFromUserDafaults(into: EpisodesModel.self) {
            return data.results[indexPathCelltable!].characters.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let networkManager = NetworkManager()
        let data: EpisodesModel? = networkManager.returnDataFromUserDafaults(into: EpisodesModel.self)
        var str = ""
        var dataCharacter: ResultsCharacters?
        if let data {
            str = data.results[indexPathCelltable!].characters[indexPath.item]
            NetworkManager().fetchPage(str: str) { data in
                if let decodedPerson: ResultsCharacters = NetworkManager().decodeData(data, into: ResultsCharacters.self) {
                    dataCharacter = decodedPerson
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                if let dataCharacter {
                    (cell as? CustomCellCharacters)?.setName(with: "\(dataCharacter.name)")
                    (cell as? CustomCellCharacters)?.setImage(with: "\(dataCharacter.image)")
                } else {
//                    let indexPathsToReload = [indexPath]
//                    collectionView.reloadItems(at: indexPathsToReload)
                }
            })
        }
        return cell
    }
}
