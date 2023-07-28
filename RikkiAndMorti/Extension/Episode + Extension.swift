//
//  Episode + Extension.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 27.07.2023.
//

import Foundation
import UIKit

extension Episode: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            


        return cell
    }
    
    
}
