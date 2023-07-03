//
//  VC+Extension.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 26.06.2023.
//

import UIKit

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if data?.results.isEmpty == false {
            (cell as? CustomCell)?.setName(with: "\(data?.results[indexPath.item].name ?? "Don't have data")")
            (cell as? CustomCell)?.setImage(with: "\(data?.results[indexPath.item].image ?? "google.com/imgres?imgurl=https%3A%2F%2Fwww.computerhope.com%2Fjargon%2Fe%2Ferror.png&tbnid=jaSzOJAVAROumM&vet=12ahUKEwjzhODk2OX_AhXLUXcKHdZ8C1oQMygDegUIARDFAQ..i&imgrefurl=https%3A%2F%2Fwww.computerhope.com%2Fjargon%2Fe%2Ferror.htm&docid=Z0ChwtQ5SLVbDM&w=350&h=329&q=error&ved=2ahUKEwjzhODk2OX_AhXLUXcKHdZ8C1oQMygDegUIARDFAQ")")
        } 
        return cell
    }
    
}
