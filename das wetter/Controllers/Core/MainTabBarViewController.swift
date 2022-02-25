//
//  ViewController.swift
//  das wetter
//
//  Created by Matias Kupfer on 19.02.22.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        tabBar.backgroundColor = .lightGray
        tabBar.tintColor = .cyan


        let vc1 = UINavigationController(rootViewController: WeatherViewController())
        let vc2 = UINavigationController(rootViewController: SavedViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "sun.min")
        vc2.tabBarItem.image = UIImage(systemName: "wind")
        
        vc1.title = "Weather"
        vc2.title = "Saved"
        
        
        setViewControllers([vc1, vc2], animated: true)
    }


}

