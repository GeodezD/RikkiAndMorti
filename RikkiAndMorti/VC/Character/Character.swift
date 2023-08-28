//
//  ViewCell.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 10.07.2023.
//

import UIKit

class Character: UIViewController {
    
    var indexPathCell: Int?
    private let viewImage = UIImageView()
    private let navigation = UINavigationItem()
    private let navigationBar = UINavigationBar()
    private let collectionView = CollectionView(frame: .zero, collectionViewLayout: .init()).setupCollectionView()
    
    let myData: CharactersModel = {
        let network = NetworkManager()
        guard let data = network.returnDataFromUserDafaults(into: CharactersModel.self) else { fatalError()}
        return data
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupViewsConstraints()
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        navigationBar.setItems([navigation], animated: true)
        navigationBar.backgroundColor = .white
        navigation.title = "Character"
        let back = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(prevPage))
        navigation.leftBarButtonItem = back
        
        collectionView.dataSource = self
        collectionView.delegate =  self
        
        view.addSubview(collectionView)
        view.addSubview(navigationBar)
    }
    
    @objc func prevPage() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupViewsConstraints() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor
                                                   , constant: 8),
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            navigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            navigationBar.heightAnchor.constraint(equalToConstant: 44),
            
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            collectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 4),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
}

