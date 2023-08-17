//
//  EpisodeViewCell + extension.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 03.08.2023.
//

import UIKit

extension EpisodeViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data: EpisodesModel = NetworkManager().returnDataFromUserDafaults(into: EpisodesModel.self) {
            return data.results[indexPathCelltable!].characters.count
        }
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if let data = arrayCharactersData[indexPath.item] {
            (cell as? CustomCellCharacters)?.setName(with: "\(data.name)")
            (cell as? CustomCellCharacters)?.setImage(with: "\(data.image)")
        }
        return cell
    }
}
    
