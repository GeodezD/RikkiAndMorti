//
//  TabBarcontroller.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 19.07.2023.
//

import UIKit

final class RMTabBarController: UITabBarController {

    private let navigationBar = UINavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    private func setUpTabs() {
        let vc1 = ViewController()
        let vc2 = LocationCharacter()
        let vc3 = Episode()
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        nav1.isNavigationBarHidden = true
        nav2.isNavigationBarHidden = true
        nav3.isNavigationBarHidden = true
        
        for nav in [nav1, nav2, nav3] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        nav1.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "globe"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv"), tag: 3)
        
        setViewControllers([nav1, nav2, nav3], animated: true)
    }

}
