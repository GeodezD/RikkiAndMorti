//
//  TableView.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 17.08.2023.
//

import UIKit

class TableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView() -> UITableView {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorColor = .red
        tableView.separatorStyle = .singleLine
        tableView.separatorInsetReference = .fromAutomaticInsets
        tableView.separatorInset = .init()
        tableView.separatorInsetReference = .fromCellEdges
        tableView.layer.cornerRadius = 20
        tableView.register(.init(nibName: "EpisodeTableViewCell", bundle: nil), forCellReuseIdentifier: "EpisodeTableViewCell")
        return tableView
    }
}

