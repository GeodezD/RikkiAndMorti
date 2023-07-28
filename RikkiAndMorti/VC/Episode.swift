//
//  Episode.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 19.07.2023.
//

import UIKit

class Episode: UIViewController {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    
    private let label = UILabel()
    
    var data: EpisodesModel?
    private let activityIndikator = UIActivityIndicatorView()
    private var activityIndikatorDelegate: ActivityIndikatorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndikatorDelegate = ActivityIndikator()
        guard let activityIndikatorDelegate = activityIndikatorDelegate else { return }
        activityIndikatorDelegate.setupView().frame = view.frame
        view.addSubview(activityIndikatorDelegate.setupView())
        activityIndikatorDelegate.indikator().startAnimating()
        
        let memory = Memory()
        DispatchQueue.global(qos: .userInteractive).async {
            memory.receivingDataEpisodes()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.takeData()
            self.setup()
            self.activityIndikatorDelegate?.indikator().stopAnimating()
        })
    }
    
    private func setup() {
        view.backgroundColor = .brown
//        var text: String = "Test"
//        guard let data = data else { return }
//        print(data)
//        for i in 0..<data.results.count {
//            text += "\(data.results[i]) "
//        }
//        label.text = text
//        label.frame = CGRect(x: 20, y: 20, width: 400, height: 1000)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCellCharacters.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .systemGray6
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.itemSize = .init(width: 175, height: 200)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 2
        layout.scrollDirection = .vertical
        
//        view.addSubview(label)
        view.addSubview(collectionView)
    }
    
    func takeData() {
        let memory = Memory()
        data = memory.returnDataEpisodes()
    }
}
