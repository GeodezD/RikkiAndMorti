//
//  ColorPicker.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 21.08.2023.
//

import UIKit

class ColorPicker: UIColorPickerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    func setupConstraints() {
//        clearCacche.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            clearCacche.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            clearCacche.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            clearCacche.widthAnchor.constraint(equalToConstant: view.bounds.width),
//            clearCacche.heightAnchor.constraint(equalToConstant: view.bounds.height)
        ])
    }
    
}
