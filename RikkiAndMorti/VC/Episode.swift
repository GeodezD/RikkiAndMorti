//
//  Episode.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 19.07.2023.
//

import UIKit

class Episode: UIViewController {
    
    var data: EpisodesModel?
    private let navigation = UINavigationItem()
    private let activityIndikator = UIActivityIndicatorView()
    private var activityIndikatorDelegate: ActivityIndikatorDelegate?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        activityIndikatorDelegate = ActivityIndikator()
        guard let activityIndikatorDelegate = activityIndikatorDelegate else { return }
        activityIndikatorDelegate.setupView().frame = view.frame
        view.addSubview(activityIndikatorDelegate.setupView())
        activityIndikatorDelegate.indikator().startAnimating()
        
        DispatchQueue.global().sync {
            self.takeData()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.activityIndikatorDelegate?.indikator().stopAnimating()
            self.activityIndikatorDelegate?.setupView().removeFromSuperview()
        })
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
    
    func takeData() {
        NetworkManager().fetchPage(str: FirstPageUrl.episodes.rawValue) { data  in
            if let decodeData: EpisodesModel = NetworkManager().decodeData(data, into: EpisodesModel.self) {
                self.data = decodeData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
