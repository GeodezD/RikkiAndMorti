//
//  File.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 27.07.2023.
//
//
//import Foundation
//import UIKit
//class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
//    let cellReuseIdentifier = "cell"
//    @IBOutlet var tableView: UITableView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.animals.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // create a new cell if needed or reuse an old one
//        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
//        // set the text from the data model
//        cell.textLabel?.text = self.animals[indexPath.row]
//        return cell
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("You tapped cell number \(indexPath.row).")
//    }
//}
