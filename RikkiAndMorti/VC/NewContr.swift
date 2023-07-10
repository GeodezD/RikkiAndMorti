//
//  NewContr.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 28.06.2023.
//

import UIKit

class NewContr: UIViewController {
    let navigation = UINavigationItem()
    let navigationBar = UINavigationBar()
    var itRightBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "next"
        button.customView?.backgroundColor = .red
        return button
    }()
    var buttonCounter = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
//        setup()
    }
    
//    func setup() {
//        buttonCounter = UIButton(configuration: .filled())
//        buttonCounter.setTitle("Counter", for: .normal)
//        buttonCounter.frame = CGRect(x: 100,
//                                     y: 350,
//                                  width: (UIScreen.main.bounds.width - 40) / 2,
//                                  height: 72)
//        buttonCounter.addTarget(self, action: #selector(taskSecond), for: .touchUpInside)
//        view.addSubview(buttonCounter)
//
        
//        let image = UIImage(named: "house")?.withRenderingMode(.alwaysOriginal)
//        let image = UIImage(systemName: "house")
//        let customButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(customButtonTapped))
//        let abc = UIBarButtonItem(title: "Next page", style: .plain, target: self, action: #selector(customButtonTapped))
//        navigationItem.rightBarButtonItem = customButton
//        navigationItem.rightBarButtonItem = abc
        
//        let customButton = UIBarButtonItem(title: "Custom", style: .plain, target: self, action: #selector(customButtonTapped))
//        navigationItem.rightBarButtonItem = customButton
        
//        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//        customView.backgroundColor = .red
//        let customButton = UIBarButtonItem(customView: customView)
//        navigationItem.rightBarButtonItem = customButton
//        navigationItem.title = "Menu"
//    }
//    @objc func customButtonTapped() {
//        print("FUUUUUUUCK")
//    }
    
    @objc func taskSecond() {
        let counter = ViewController()
        navigationController?.pushViewController(counter, animated: true)
    }
    

}
