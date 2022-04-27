//
//  MainTabBar.swift
//  BestAppStoreApps
//
//  Created by Guy Twig on 27/04/2022.
//

import UIKit

class MainTabBar: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().barTintColor = .systemGray
        UITabBar.appearance().tintColor = .systemYellow
        UITabBar.appearance().backgroundColor = .black
    }
}
