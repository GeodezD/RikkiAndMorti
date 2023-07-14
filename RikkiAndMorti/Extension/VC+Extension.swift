//
//  VC+Extension.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 26.06.2023.
//

import UIKit

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         data?.results.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if data?.results.isEmpty == false {
            guard let data = data else { fatalError(" None data ") }
            
            (cell as? CustomCell)?.setName(with: "\(data.results[indexPath.item].name)")
            (cell as? CustomCell)?.setImage(with: "\(data.results[indexPath.item].image)")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.item)")
        let viewCell = ViewCell()
        viewCell.indexPathCell = indexPath.item
        present(viewCell, animated: true, completion: nil)

    }
}
