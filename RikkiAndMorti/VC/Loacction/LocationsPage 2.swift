//
//  LocationCharacter.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 19.07.2023.
//

import UIKit

class LocationsPage: UIViewController {
    var data: LocationsModel?
    private let activityIndikator = ActivityIndikator()
    private let tableView = TableView(frame: .zero, style: .plain).setupTableView()
    private let time = 0.5
    
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
    
    func setup() {
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
    
    private func takeData(_ url: String = FirstPageUrl.locations.rawValue) {
        NetworkManager().fetchPage(str: url) { data  in
            if let decodeData: LocationsModel = NetworkManager().decodeData(data, into: LocationsModel.self) {
                self.data = decodeData
                print(decodeData)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
//                    self.setupBarButtomItem()
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.time, execute: {
                        self.activityIndikator.activate(.off)
                    })
                }
            }
        }
    }
    
    func startAcitivityIndikator() {
        activityIndikator.takeFrame(frame: view.frame)
        view.addSubview(activityIndikator.setupView())
        activityIndikator.activate(.on)
    }
}
