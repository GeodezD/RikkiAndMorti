//
//  TabBarcontroller.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 19.07.2023.
//

import UIKit

final class TabBarController: UITabBarController {

    private let navigationBar = UINavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    private func setUpTabs() {
        let vc1 = Characters()
        let vc2 = Location()
        let vc3 = Episode()
        let vc4 = SettingViewController()
        
        
//        let nav1 = UINavigationController(rootViewController: vc1)
//        let nav2 = UINavigationController(rootViewController: vc2)
//        let nav3 = UINavigationController(rootViewController: vc3)
//        let nav4 = UINavigationController(rootViewController: vc4)
        
        let nav1 = UINavigationController(rootViewController: vc3)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc1)
        let nav4 = UINavigationController(rootViewController: vc4)
        
        nav1.isNavigationBarHidden = true
        nav2.isNavigationBarHidden = true
        nav3.isNavigationBarHidden = true
        nav4.isNavigationBarHidden = true
        
        for nav in [nav1, nav2, nav3, nav4] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        nav1.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "globe"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(systemName: "gearshape.fill"), tag: 4)
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
    }

}
