//
//  TableViewInCollectionViewCell.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 21.08.2023.
//

import UIKit

class TableViewInCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    private let activityIndikator = ActivityIndikator()
    private let navigation = UINavigationItem()
    private let time = 0.5
    private var data: EpisodesModel?
    
    private let tableView = TableView(frame: .zero, style: .plain).setupTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
    }
    
    func setupConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
    func takeData(_ url: String = FirstPageUrl.episodes.rawValue) {
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = data else { fatalError(" None data") }
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell", for: indexPath)
        guard let episodeCell = cell as? EpisodeTableViewCell else { fatalError("EpisodeTableViewCell = NIL") }
        
        episodeCell.setLabel(with: "\(data.results[indexPath.item].episode)",
                             label: episodeCell.labelEpisode,
                                                  font: 20,
                             name: "Episode",
                             bold: true)
        
        episodeCell.setLabel(with: "\(data.results[indexPath.item].name)",
                             label: episodeCell.labelNameEpisode,
                             font: 18,
                             name: "Name",
                             bold: false)
        
        episodeCell.setLabel(with: "\(data.results[indexPath.item].airDate)",
                             label: episodeCell.labelAired,
                             font: 16,
                             name: "Aired",
                             bold: false)
        return cell
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
