//
//  Character + extension.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 17.08.2023.
//

import UIKit

extension Character: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let indexPathCell else { fatalError() }
        return data.results[indexPathCell].episode.count + 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextCollectionViewCell", for: indexPath)
        cell.backgroundColor = .systemGray5
        let textCollectionViewCell = cell as? TextCollectionViewCell
        
        guard let indexPathCell else { fatalError() }
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath)
            (cell as? ImageCollectionViewCell)?.setImage(with: "\(data.results[indexPathCell].image)")
            return cell
        case 1:
            textCollectionViewCell?.setText(text: "Name:")
        case 2:
            textCollectionViewCell?.setText(text: "\(data.results[indexPathCell].name)")
        case 3:
            textCollectionViewCell?.setText(text: "STATUS:")
        case 4:
            textCollectionViewCell?.setText(text: "\(data.results[indexPathCell].status)")
        case 5:
            textCollectionViewCell?.setText(text: "GENDER:")
        case 6:
            textCollectionViewCell?.setText(text: "\(data.results[indexPathCell].gender)")
        case 7:
            textCollectionViewCell?.setText(text: "SPECIES:")
        case 8:
            textCollectionViewCell?.setText(text: "\(data.results[indexPathCell].species)")
        case 9:
            textCollectionViewCell?.setText(text: "LOCATION:")
        case 10:
            textCollectionViewCell?.setText(text: "\(data.results[indexPathCell].origin.name)")
        case 11:
            textCollectionViewCell?.setText(text: "EPISODE:")
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextCollectionViewCell", for: indexPath)
            cell.backgroundColor = .systemGray5
            (cell  as? TextCollectionViewCell)?.fetchData(data.results[indexPathCell].episode[indexPath.item - 12])
            return cell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return CGSize(width: 300, height: 300)
        case 1...11:
            return CGSize(width: collectionView.frame.width, height: 50)
        default:
            return CGSize(width: collectionView.frame.width, height: 75)
        }
    }
}
