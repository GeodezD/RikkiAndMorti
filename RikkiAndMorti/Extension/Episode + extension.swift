//
//  EpisodeViewCell + extension.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 03.08.2023.
//

import UIKit

extension Episode: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data: EpisodesModel = NetworkManager().returnDataFromUserDafaults(into: EpisodesModel.self) {
            return data.results[indexPathCelltable!].characters.count
        }
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if let data = arrayCharactersData[indexPath.item] {
            (cell as? CollectionViewCustomCell)?.setName(with: "\(data.name)")
            (cell as? CollectionViewCustomCell)?.setImage(with: "\(data.image)")
        }
        return cell
    }
}
    
