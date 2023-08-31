//
//  EpisodeViewCell + extension.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 03.08.2023.
//

import UIKit

extension CharactersInEpisode: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data: EpisodesModel = NetworkManager().returnDataFromUserDafaults(into: EpisodesModel.self) {
            return data.results[indexPathCelltable!].characters.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCustomCell", for: indexPath)
        
        if let data = arrayCharactersData[indexPath.item] {
            (cell as? CollectionViewCustomCell)?.setName(with: "\(data.name)")
            (cell as? CollectionViewCustomCell)?.setImage(with: "\(data.image)")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2 - 4
        return CGSize(width: width, height: width / 10 + width)
    }
}
    
