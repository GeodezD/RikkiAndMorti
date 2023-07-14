//
//  ViewController.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 21.06.2023.
//

import UIKit

class ViewController: UIViewController {
    private var url = "https://rickandmortyapi.com/api/character/?page=1"
    private let network = NetworkManager()
    private let navigation = UINavigationItem()
    private let memory = Memory()
    var data: Model?
    
    private let navigationBar = UINavigationBar()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        DispatchQueue.global(qos: .userInitiated).sync {
            self.fetchData()
        }
        //        fetchData()
        setup()
        DispatchQueue.main.async {
            self.importInVCData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupPosition()
    }
    
    private func setup() {
        navigationBar.setItems([navigation], animated: true)
        navigationBar.backgroundColor = .white
        view.addSubview(navigationBar)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .systemGray6
        
        navigation.title = "Character"
        let next = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextPage))
        self.navigation.rightBarButtonItem = next
        let back = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(prevPage))
        self.navigation.leftBarButtonItem = back
        
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.itemSize = .init(width: 175, height: 200)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 2
        layout.scrollDirection = .vertical
        view.addSubview(collectionView)
    }
    
    @objc func nextPage() {
        guard let next = self.memory.exportData()?.info.next else { return }
        prevOrNextPage(next)
    }
    
    @objc func prevPage() {
        guard let prev = self.memory.exportData()?.info.prev else { return }
        prevOrNextPage(prev)
    }
    
    private func prevOrNextPage(_ str: String) {
        DispatchQueue.global().async {
            self.memory.importData(str)
        }
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 0.5) {
            DispatchQueue.main.async {
                self.importInVCData()
            }
        }
    }
    
    private func setupPosition() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor
                                                   , constant: 12),
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            navigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            navigationBar.heightAnchor.constraint(equalToConstant: 44),
            
            collectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
        ])
    }
    
    private func fetchData() {
        memory.importData()
    }
    
    private func importInVCData() {
        data = memory.exportData()
        //        memory.exportData { model in
        //            guard let model = model else { return }
        //            self.data = model
        //        }
        DispatchQueue.main.async {
            self.setupBarButtomItem()
            self.collectionView.reloadData()
        }
        
    }
    
    private func setupBarButtomItem() {
        switch (data?.info.prev, data?.info.next) {
        case (data?.info.prev, _) where data?.info.prev == nil:
            navigation.rightBarButtonItem?.isHidden = false
            navigation.leftBarButtonItem?.isHidden = true
        case (_, data?.info.next) where data?.info.next == nil:
            navigation.rightBarButtonItem?.isHidden = true
            navigation.leftBarButtonItem?.isHidden = false
        default:
            navigation.rightBarButtonItem?.isHidden = false
            navigation.leftBarButtonItem?.isHidden = false
        }
    }
}

