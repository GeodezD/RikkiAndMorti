//
//  LaunchScreen.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 17.07.2023.
//

import UIKit

class LaunchScreen: UIViewController {
   private let viewImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        DispatchQueue.main.asyncAfter(deadline: .now() +  0) {
            self.nextViewController()
        }
    }
    
    func setup() {
        viewImage.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        viewImage.image = UIImage(named: "launch_screen_image")
        view.addSubview(viewImage)
    }
    
    func nextViewController() {
        navigationController?.pushViewController(RMTabBarController(), animated: false)
    }
}
