//
//  VC+Extension.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 26.06.2023.
//

import UIKit

extension CharactersPage: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         data?.results.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCustomCell", for: indexPath)
        if let data {
            (cell as? CollectionViewCustomCell)?.setName(with: "\(data.results[indexPath.item].name)")
            (cell as? CollectionViewCustomCell)?.setImage(with: "\(data.results[indexPath.item].image)")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.item)")
        let viewCell = Character()
        viewCell.indexPathCell = indexPath.item
        navigationController?.pushViewController(viewCell, animated: true)
    }
}
