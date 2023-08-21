//
//  CollectionView.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 17.08.2023.
//

import UIKit

class CollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView(width: CGFloat = 175, height: CGFloat = 200) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        collectionView.register(CollectionViewCustomCell.self, forCellWithReuseIdentifier: "CollectionViewCustomCell")
        collectionView.register(ImageTestCollectionViewCell.self, forCellWithReuseIdentifier: "ImageTestCollectionViewCell")
        collectionView.register(.init(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        collectionView.register(.init(nibName: "TextCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TextCollectionViewCell")
        collectionView.register(.init(nibName: "TextViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TextViewCollectionViewCell")
        collectionView.backgroundColor = .systemGray6
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { fatalError() }
        layout.itemSize = .init(width: width, height: height)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 2
        layout.scrollDirection = .vertical
        return collectionView
    }
}


