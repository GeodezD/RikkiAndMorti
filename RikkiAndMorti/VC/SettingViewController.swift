//
//  SettingViewController.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 11.08.2023.
//

import UIKit

class SettingViewController: UIViewController {
    
    private let button = UIButton(configuration: .filled())

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        button.frame = CGRect(x: 50, y: 50, width: 300, height: 44)
        button.setTitle("Clear cache", for: .normal)
        button.addAction(UIAction { _ in
            let cache = GetImage()
            cache.clearCache()
            print("Cache clear")
        }, for: .touchUpInside)
        view.addSubview(button)
    }
}
 
