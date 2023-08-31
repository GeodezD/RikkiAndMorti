//
//  LocationsPage.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 30.08.2023.
//

import UIKit

class LocationsPage: ViewControllerWithTableView {
    var data: LocationsModel?
    lazy private var numberPage = 1
    let textTitle = "Locations page:"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAcitivityIndikator()
        data = takeData(FirstPageUrl.locations.url, type: LocationsModel.self)
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
        data = takeData(next, type: LocationsModel.self)
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
        data = takeData(prev, type: LocationsModel.self)
        numberPage -= 1
        if let data {
            navigationTitle(title: "\(textTitle) \(numberPage)/\(data.info.pages)")
            setupBarButtomItem(prev: data.info.prev, next: data.info.next)
        }
        tableView.reloadData()
    }
}
