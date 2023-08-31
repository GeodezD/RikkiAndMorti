//
//  CharactersPage.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 28.08.2023.
//

import UIKit

class CharactersPage: ViewControllerWithCollectionView {

    var data: CharactersModel?
    lazy private var numberPage = 1
    let textTitle = "Characters:"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAcitivityIndikator()
        data = takeData(FirstPageUrl.characters.url, type: CharactersModel.self)
        if let data {
            setupBarButtomItem(prev: data.info.prev, next: data.info.next)
            navigationTitle(title: "\(textTitle) \(numberPage)/\(data.info.pages)")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func setup() {
        super.setup()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func nextPage() {
        startAcitivityIndikator()
        guard let next = self.data?.info.next else { return }
        data = takeData(next, type: CharactersModel.self)
        numberPage += 1
        if let data {
            navigationTitle(title: "\(textTitle) \(numberPage)/\(data.info.pages)")
            setupBarButtomItem(prev: data.info.prev, next: data.info.next)
        }
        collectionView.reloadData()
    }
    
    override func prevPage() {
        startAcitivityIndikator()
        guard let prev = self.data?.info.prev else { return }
        data = takeData(prev, type: CharactersModel.self)
        numberPage -= 1
        if let data {
            navigationTitle(title: "\(textTitle) \(numberPage)/\(data.info.pages)")
            setupBarButtomItem(prev: data.info.prev, next: data.info.next)
        }
        collectionView.reloadData()
    }
}


