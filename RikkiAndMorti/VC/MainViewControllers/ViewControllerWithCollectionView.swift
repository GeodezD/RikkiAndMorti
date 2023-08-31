//
//  ViewController.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 28.08.2023.
//

import UIKit

//enum DecodingType {
//    case charactersModel
//    case resultsCharacters
//    case episodesModel
//    case locationsModel
//    case resultsEpisodes
//
//    var decodingType: Decodable.Type {
//        switch self {
//        case .charactersModel:
//            return CharactersModel.self
//        case .episodesModel:
//            return EpisodesModel.self
//        case .locationsModel:
//            return LocationsModel.self
//        case .resultsCharacters:
//            return ResultsCharacters.self
//        }
//    }
//}

class ViewControllerWithCollectionView: UIViewController {
    
    lazy var collectionView = CollectionView(frame: .zero, collectionViewLayout: .init()).setupCollectionView()
    private let activityIndikator = ActivityIndikator()
    let navigation = UINavigationItem()
    let navigationBar = UINavigationBar()
    private var time = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraint()
        activityIndikator.takeFrame(frame: view.frame)
    }
    
    func setup() {
        navigationBar.setItems([navigation], animated: true)
        navigationBar.backgroundColor = .white
        navigation.title = ""
        let next = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextPage))
        navigation.rightBarButtonItem = next
        let back = UIBarButtonItem(title: "Prev", style: .plain, target: self, action: #selector(prevPage))
        navigation.leftBarButtonItem = back
        
        view.addSubview(navigationBar)
        view.addSubview(collectionView)
    }
    
    func navigationTitle(title text: String) {
        navigation.title = text
    }
    
    func takeData<T: Decodable>(_ url: String, type: T.Type) -> T? {
        var cacheData: Data?
        let semaphore = DispatchSemaphore(value: 0)
        var saveData: T?
        NetworkManager().fetchPage(str: url) { data in
            cacheData  = data
            semaphore.signal()
        }
        semaphore.wait()
        if let cacheData {
            if let decodeData = NetworkManager().decodeData(cacheData, into: type) {
                saveData = decodeData
                DispatchQueue.main.asyncAfter(deadline: .now() + self.time, execute: {
                    self.stopAcitivityIndikator()
                })
            }
        }
        return saveData
    }
    
    func setupConstraint() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor
                                                   , constant: 0),
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                               constant: 0),
            navigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                    constant: 0),
            navigationBar.heightAnchor.constraint(equalToConstant: 44),
            
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            collectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: ACtivityIndikator start/stop
    func startAcitivityIndikator() {
        activityIndikator.takeFrame(frame: view.frame)
        view.addSubview(activityIndikator.setupView())
        activityIndikator.activate(.on)
    }
    
    func stopAcitivityIndikator() {
        activityIndikator.activate(.off)
    }
    
    // MARK: BarButtomItem is Hedden
    func setupBarButtomItem(prev: String?, next: String?) {
        switch (prev, next) {
        case (prev, _) where prev == nil:
            navigation.rightBarButtonItem?.isHidden = false
            navigation.leftBarButtonItem?.isHidden = true
        case (_, next) where next == nil:
            navigation.rightBarButtonItem?.isHidden = true
            navigation.leftBarButtonItem?.isHidden = false
        default:
            navigation.rightBarButtonItem?.isHidden = false
            navigation.leftBarButtonItem?.isHidden = false
        }
    }
    
    @objc func nextPage() {  }
    
    @objc func prevPage() {  }
}
