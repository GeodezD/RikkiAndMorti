//
//  EpisodeViewCell + extension.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 03.08.2023.
//

import UIKit

extension EpisodeViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let memory = Memory()
        let data: EpisodesModel = memory.returnDataEpisodes()
        return data.results[indexPathCelltable!].characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let memory = Memory()
        var str = ""
        var data: EpisodesModel?
        data = memory.returnDataEpisodes()
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
                    let indexPathsToReload = [indexPath]
                    collectionView.reloadItems(at: indexPathsToReload)
                }
            })
            
        }
        return cell
    }
}
