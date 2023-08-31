//
//  EpisodePage.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 29.08.2023.
//

import UIKit

class EpisodesPage: ViewControllerWithTableView {
    
    var data: EpisodesModel?
    lazy private var numberPage = 1
    let textTitle = "Episode page:"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAcitivityIndikator()
        data = takeData(FirstPageUrl.episodes.url, type: EpisodesModel.self)
        if let data {
            setupBarButtomItem(prev: data.info.prev, next: data.info.next)
            navigationTitle(title: "\(textTitle) \(numberPage)/\(data.info.pages)")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func setup() {
        super.setup()
        
        tableView.delegate  = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }
    
    override func nextPage() {
        startAcitivityIndikator()
        guard let next = self.data?.info.next else { return }
        data = takeData(next, type: EpisodesModel.self)
        numberPage += 1
        if let data {
            navigationTitle(title: "\(textTitle) \(numberPage)/\(data.info.pages)")
            setupBarButtomItem(prev: data.info.prev, next: data.info.next)
        }
        tableView.reloadData()
    }
    
    override func prevPage() {
        startAcitivityIndikator()
        guard let prev = self.data?.info.prev else { return }
        data = takeData(prev, type: EpisodesModel.self)
        numberPage -= 1
        if let data {
            navigationTitle(title: "\(textTitle) \(numberPage)/\(data.info.pages)")
            setupBarButtomItem(prev: data.info.prev, next: data.info.next)
        }
        tableView.reloadData()
    }
}
