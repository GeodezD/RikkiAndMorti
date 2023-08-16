//
//  EpisodeViewCell.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 03.08.2023.
//

import UIKit

class EpisodeViewCell: UIViewController {
    
    var indexPathCelltable: Int?
    var arrayCharacters = [ResultsCharacters?]()
    
    private let navigation = UINavigationItem()
    private let navigationBar = UINavigationBar()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
//        DispatchQueue.global(qos: .userInteractive).sync {
//            self.loadData()
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupViewsConstraints()
        collectionView.reloadData()
    }
    
    private func setup() {
        navigationBar.setItems([navigation], animated: true)
        navigationBar.backgroundColor = .white
        navigation.title = "Characters in episode"
        let back = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(prevPage))
        self.navigation.leftBarButtonItem = back
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCellCharacters.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .systemGray6
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.itemSize = .init(width: 175, height: 200)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 2
        layout.scrollDirection = .vertical
        
        view.addSubview(navigationBar)
        view.addSubview(collectionView)
    }
    
    @objc func prevPage() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupViewsConstraints() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                   constant: 8),
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                               constant: 0),
            navigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                    constant: -8),
            navigationBar.heightAnchor.constraint(equalToConstant: 44),
            
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: 8),
            collectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor,
                                                constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                     constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                   constant: -8)
        ])
    }
    
//    func loadData(indexPath: IndexPath, completion: @escaping (ResultsCharacters?) -> Void ) {
//
//        let data: EpisodesModel? = NetworkManager().returnDataFromUserDafaults(into: EpisodesModel.self)
//
//        if let data, let indexPathCelltable {
//            let str = data.results[indexPathCelltable].characters[indexPath.item]
//
//            NetworkManager().fetchPage(str: str) { data in
//                let decodedPerson: ResultsCharacters? = NetworkManager().decodeData(data, into: ResultsCharacters.self)
//                completion(decodedPerson)
//            }
//        }
//    }
    
    func loadData() {
        
        let data: EpisodesModel? = NetworkManager().returnDataFromUserDafaults(into: EpisodesModel.self)
        
        if let data, let indexPathCelltable {
            var arrayCharacters: [ResultsCharacters?] = []
            for url in data.results[indexPathCelltable].characters {
                NetworkManager().fetchPage(str: url) { data in
                    let decodedPerson: ResultsCharacters? = NetworkManager().decodeData(data, into: ResultsCharacters.self)
                    arrayCharacters.append(decodedPerson)
                }
            }
        }
    }
    
    
}
