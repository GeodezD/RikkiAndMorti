//
//  Characters.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 21.06.2023.
//

import UIKit

class Characters: UIViewController {
    
    var data: CharactersModel?
    private let activityIndikator = ActivityIndikator()
    private let navigation = UINavigationItem()
    private let navigationBar = UINavigationBar()
    private let subView = UIView()
    private let time = 0.5
    
    private let collectionView = CollectionView(frame: .zero, collectionViewLayout: .init()).setupCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addView()
        startAcitivityIndikator()
        
        DispatchQueue.global(qos: .userInteractive).sync {
            self.takeData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraint()
        activityIndikator.takeFrame(frame: view.frame)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
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
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    private func setupConstraint() {
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
        startAcitivityIndikator()
        guard let next = self.data?.info.next else { return }
        takeData(next)
        coollectionViewScrollTop()
    }
    
    @objc func prevPage() {
        startAcitivityIndikator()
        guard let prev = self.data?.info.prev else { return }
        takeData(prev)
        coollectionViewScrollTop()
    }
    
    private func coollectionViewScrollTop() {
        let sectionCount = collectionView.numberOfSections
        let lastSection = sectionCount - 1
        let itemCount = collectionView.numberOfItems(inSection: lastSection)
        guard itemCount > 0 else { return }
        let firstItemIndexPath = IndexPath(item: 0, section: lastSection)
        collectionView.scrollToItem(at: firstItemIndexPath, at: .bottom, animated: true)
    }
    
    private func takeData(_ url: String = FirstPageUrl.characters.rawValue) {
        NetworkManager().fetchPage(str: url) { data  in
            if let decodeData: CharactersModel = NetworkManager().decodeData(data, into: CharactersModel.self) {
                self.data = decodeData
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.setupBarButtomItem()
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.time, execute: {
                        self.activityIndikator.activate(.off)
                    })
                }
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
    
    private func startAcitivityIndikator() {
        activityIndikator.takeFrame(frame: view.frame)
        view.addSubview(activityIndikator.setupView())
        activityIndikator.activate(.on)
    }
}

