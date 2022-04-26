//
//  FavoritesViewController.swift
//  BestAppStoreApps
//
//  Created by Guy Twig on 25/04/2022.
//

import Foundation
import UIKit

class FavoritesViewController: UIViewController {
    
    var favArray: [Results] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let fav = UserDefaults.standard.favListSave {
            favArray = fav
        }
    }
}
