//
//  Settings.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 28.06.2023.
//

import UIKit


class Settings: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
//        setup()
        createToolbar()
    }
    
    func setup() {
        let  nav = UITabBar()
        nav.barStyle = .black
        view.addSubview(nav)


    }
    func createToolbar(){
        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toolbar)

        // Налаштування констрейнтів для UIToolbar
        toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        // Додавання кнопок до UIToolbar
        let button1 = UIBarButtonItem(title: "Button 1", style: .done, target: self, action: #selector(button1Tapped))
        let button2 = UIBarButtonItem(title: "Button 2", style: .plain, target: self, action: #selector(button2Tapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([button1, flexibleSpace, button2], animated: false)

    }
    
    @objc func button1Tapped() {
        let counter = ViewController()
        navigationController?.pushViewController(counter, animated: true)
    }
    
    @objc func button2Tapped() {
        let counter = Settings()
        navigationController?.pushViewController(counter, animated: true)
    }

}

