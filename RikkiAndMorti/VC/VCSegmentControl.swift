//
//  VCSegmentControl.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 18.07.2023.
//

import UIKit

class VCSegmentControl: UIViewController {
    let segmentedControl = UISegmentedControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControl()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        segmentedControl.frame = CGRect(x: 16, y: 200, width: 300, height: 44)
        setupPositionSegmentControl()
    }
    
    func setupSegmentedControl() {
        segmentedControl.insertSegment(withTitle: "Character", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "Episode", at: 1, animated: true)
        segmentedControl.insertSegment(withTitle: "Location", at: 2, animated: true)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(targetNew), for: .valueChanged)
        
        view.addSubview(segmentedControl)
    }
    
    @objc func targetNew(element: UISegmentedControl) {
        print(element.selectedSegmentIndex)
        switch element.selectedSegmentIndex {
        case 0:
            segmentedControl.selectedSegmentIndex = 0
        case 1:
            segmentedControl.selectedSegmentIndex = 1
        default:

            segmentedControl.selectedSegmentIndex = 2
        }
    }
    
    func setupPositionSegmentControl() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            segmentedControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
}
