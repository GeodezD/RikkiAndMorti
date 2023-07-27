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
        DispatchQueue.main.asyncAfter(deadline: .now() +  0.5) {
            self.nextViewController()
        }
    }
    
    func setup() {
        viewImage.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        viewImage.image = UIImage(named: "launch_screen_image")
//        viewImage.animationImages = viewImage.image?.images
//        viewImage.animationDuration = viewImage.image?.duration ?? 3.0
//        viewImage.animationRepeatCount = 0
//        viewImage.startAnimating()
        view.addSubview(viewImage)
    }
    
    func nextViewController() {
        navigationController?.pushViewController(RMTabBarController(), animated: true)
    }
}
