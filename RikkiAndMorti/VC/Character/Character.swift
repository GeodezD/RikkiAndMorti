//
//  Character.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 29.08.2023.
//

import UIKit

class Character: ViewControllerWithCollectionView {
    
    var indexPathCell: Int?
    let character = "Character"
    let data: CharactersModel = {
            let network = NetworkManager()
            guard let data = network.returnDataFromUserDafaults(into: CharactersModel.self) else { fatalError()}
            return data
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationTitle(title: "\(character)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        stopAcitivityIndikator()
    }
    
    override func setup() {
        super.setup()
        
        navigation.rightBarButtonItem = nil
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func prevPage() {
        navigationController?.popViewController(animated: true)
    }
}
