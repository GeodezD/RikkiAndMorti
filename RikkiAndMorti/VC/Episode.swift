//
//  Episode.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 19.07.2023.
//

import UIKit

class Episode: UIViewController {
    
    var data: EpisodesModel?
    private let activityIndikator = ActivityIndikator()
    private let navigation = UINavigationItem()
    private let time = 0.5
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        DispatchQueue.global(qos: .userInteractive).sync {
            self.takeData()
        }
        startAcitivityIndikator()
        

    }
    
    override func viewWillLayoutSubviews() {
        setupConstraint()
    }
    
    private func setup() {
        view.backgroundColor = .white
        tableView.separatorColor = .red
        tableView.separatorStyle = .singleLine
        tableView.separatorInsetReference = .fromCellEdges
        tableView.separatorInset = UIEdgeInsets(top: 100, left: 0, bottom: 20, right: 0);
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 20
        tableView.register(.init(nibName: "EpisodeTableViewCell", bundle: nil), forCellReuseIdentifier: "EpisodeTableViewCell")
        
        view.addSubview(tableView)
    }
    
    func setupConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
    }
    
    private func takeData(_ url: String = FirstPageUrl.episodes.rawValue) {
        NetworkManager().fetchPage(str: url) { data  in
            if let decodeData: EpisodesModel = NetworkManager().decodeData(data, into: EpisodesModel.self) {
                self.data = decodeData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.setupBarButtomItem()
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.time, execute: {
                        self.stopAcitivityIndikator()
                    })
                }
            }
        }
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.setupBarButtomItem()
            self.collectionView.reloadData()
            self.stopAcitivityIndikator()
        }
    }
    
    func coollectionViewScrollTop() {
        let sectionCount = collectionView.numberOfSections
        let lastSection = sectionCount - 1
        let itemCount = collectionView.numberOfItems(inSection: lastSection)
        guard itemCount > 0 else { return }
        let firstItemIndexPath = IndexPath(item: 0, section: lastSection)
        collectionView.scrollToItem(at: firstItemIndexPath, at: .bottom, animated: true)
    }
    
//    @objc func nextPage() {
//        startAcitivityIndikator()
//        guard let next = self.data?.info.next else { return }
//        prevOrNextPage(next)
//        coollectionViewScrollTop()
//    }
//
//    @objc func prevPage() {
//        startAcitivityIndikator()
//        guard let prev = self.data?.info.prev else { return }
//        prevOrNextPage(prev)
//        coollectionViewScrollTop()
//    }
    
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
    
    func startAcitivityIndikator() {
        activityIndikator.takeFrame(frame: view.frame)
        view.addSubview(activityIndikator.setupView())
        activityIndikator.indikator().startAnimating()
    }
    
    func stopAcitivityIndikator() {
        self.activityIndikator.indikator().stopAnimating()
        self.activityIndikator.setupView().removeFromSuperview()
    }
    
}
