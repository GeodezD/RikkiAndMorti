//
//  Episode.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 19.07.2023.
//

import UIKit

class EpisodesPage: UIViewController {
    
    var data: EpisodesModel?
    private let activityIndikator = ActivityIndikator()
    private let navigation = UINavigationItem()
    private let time = 0.5
    
    private let tableView = TableView(frame: .zero, style: .plain).setupTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        DispatchQueue.global(qos: .userInteractive).sync {
            self.takeData()
        }
        startAcitivityIndikator()
    }
    
    
    override func viewDidLayoutSubviews() {
        setupConstraint()
    }
    
    private func setup() {
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
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
                        self.activityIndikator.activate(.off)
                    })
                }
            }
        }
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
        activityIndikator.activate(.on)
    }
}
