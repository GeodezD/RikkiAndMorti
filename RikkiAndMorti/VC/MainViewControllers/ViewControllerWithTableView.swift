//
//  ViewControllerWithTableView.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 29.08.2023.
//

import UIKit

class ViewControllerWithTableView: UIViewController {
    
    let tableView = TableView(frame: .zero, style: .plain).setupTableView()
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
        let back = UIBarButtonItem(title: "Prev", style: .plain, target: self, action: #selector(prevPage))
        navigation.rightBarButtonItem = next
        navigation.leftBarButtonItem = back
        
        view.addSubview(navigationBar)
        view.addSubview(tableView)
    }
    
    func setupConstraint() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            navigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor
                                                   , constant: 0),
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                               constant: 0),
            navigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                    constant: 0),
            navigationBar.heightAnchor.constraint(equalToConstant: 44),

            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
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
