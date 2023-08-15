//
//  TestGIFImage.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 14.08.2023.
//

import UIKit

class TestGIFImage:  UIViewController {
    var image = UIImage(named: "portal-rick-and-morty.gif")
    var viewImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2
        viewImage.frame = CGRect(x: 50, y: 50, width: 300, height: 300)
        viewImage.image = image
        view.addSubview(viewImage)
        
    }
}


