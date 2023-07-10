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
        setup()
        DispatchQueue.main.async {
            self.fetchData()
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
        guard let next = data?.info.next else { return }
        self.url = next
        fetchData()
    }
    
    @objc func prevPage() {
        guard let prev = data?.info.prev else { return }
        self.url = prev
        fetchData()
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
        NetworkManager().fetchPage(str: url) { model in
            self.data = model
            DispatchQueue.main.async { [self] in
                setupBarButtomItem()
                self.collectionView.reloadData()
            }
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
    
    func transferData(completion: @escaping ((Model?) -> Void)) {
        completion(self.data)
    }
    
    deinit {
        print("I'm DEAD!!!!")
    }
}

