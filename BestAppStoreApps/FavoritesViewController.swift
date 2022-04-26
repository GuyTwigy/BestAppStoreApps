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
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: FavCell.nibName, bundle: nil), forCellWithReuseIdentifier: FavCell.nibName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let fav = UserDefaults.standard.favListSave {
            favArray = fav
            collectionView.reloadData()
        }
    }
}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavCell.nibName, for: indexPath) as! FavCell
        cell.favArray = favArray
        cell.index = indexPath.row
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width) / 2.3
        return CGSize(width: width, height: width)
    }
}

extension FavoritesViewController: FavCellDelegate {
    func updateFavArray(favArray: [Results]) {
        self.favArray = favArray
        UserDefaults.standard.favListSave = self.favArray
        collectionView.reloadData()
    }
}


