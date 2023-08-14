//
//  Characters.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 21.06.2023.
//

import UIKit

class Characters: UIViewController {
    
    var data: CharactersModel?
    private let navigation = UINavigationItem()
    private let navigationBar = UINavigationBar()
    private var activityIndikatorDelegate: ActivityIndikatorDelegate?
    private let subView = UIView()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addView()
        
        activityIndikatorDelegate = ActivityIndikator()
        guard let activityIndikatorDelegate = activityIndikatorDelegate else { return }
        activityIndikatorDelegate.setupView().frame = view.frame
        view.addSubview(activityIndikatorDelegate.setupView())
        activityIndikatorDelegate.indikator().startAnimating()
    
        DispatchQueue.global(qos: .userInteractive).sync {
            self.fetchData()
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2, execute: {
            self.importInVCData()
            DispatchQueue.main.async {
                self.activityIndikatorDelegate?.indikator().stopAnimating()
                self.activityIndikatorDelegate?.setupView().removeFromSuperview()
            }
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupPosition()
    }
    
    func addView() {
        view.addSubview(subView)
        subView.addSubview(navigationBar)
        subView.addSubview(collectionView)
    }
    
    private func setup() {
        navigationBar.setItems([navigation], animated: true)
        navigationBar.backgroundColor = .white
        navigation.title = "Characters"
        let next = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextPage))
        self.navigation.rightBarButtonItem = next
        let back = UIBarButtonItem(title: "Prev", style: .plain, target: self, action: #selector(prevPage))
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
    }
    
    private func setupPosition() {
            subView.translatesAutoresizingMaskIntoConstraints = false
            navigationBar.translatesAutoresizingMaskIntoConstraints = false
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                subView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
                subView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
                subView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
                subView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
                
                navigationBar.leadingAnchor.constraint(equalTo: subView.leadingAnchor
                                                       , constant: 0),
                navigationBar.topAnchor.constraint(equalTo: subView.topAnchor, constant: 0),
                navigationBar.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: 0),
                navigationBar.heightAnchor.constraint(equalToConstant: 44),
                
                collectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 0),
                collectionView.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: 0),
                collectionView.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 0),
                collectionView.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: 0),
                
            ])
        }
    
    @objc func nextPage() {
        guard let next = self.data?.info.next else { return }
        prevOrNextPage(next)
        coollectionViewScrollTop()
    }
    
    @objc func prevPage() {
        guard let prev = self.data?.info.prev else { return }
        prevOrNextPage(prev)
        coollectionViewScrollTop()
    }
    
    func coollectionViewScrollTop() {
        let sectionCount = collectionView.numberOfSections
        let lastSection = sectionCount - 1
        let itemCount = collectionView.numberOfItems(inSection: lastSection)
        guard itemCount > 0 else { return }
        let firstItemIndexPath = IndexPath(item: 0, section: lastSection)
        collectionView.scrollToItem(at: firstItemIndexPath, at: .bottom, animated: true)
    }
    
    private func prevOrNextPage(_ str: String) {
        DispatchQueue.global().async {
            let memory = Memory()
            memory.receivingDataCharacters(str)
        }
        
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 0.5) {
            DispatchQueue.main.async {
                self.importInVCData()
            }
        }
    }
    
    private func fetchData() {
//        let memory = Memory()
//        memory.receivingDataCharacters()
        
        NetworkManager().fetchPage(str: FirstPageUrl.characters.rawValue) { data  in
            if let decodeData: CharactersModel = NetworkManager().decodeData(data, into: CharactersModel.self) {
                self.data = decodeData
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
    }
    
    private func importInVCData() {
        let memory = Memory()
        data = memory.returnDataCharacters()
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

