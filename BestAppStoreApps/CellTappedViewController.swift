//
//  CellTappedViewController.swift
//  BestAppStoreApps
//
//  Created by Guy Twig on 01/05/2022.
//

import Foundation
import UIKit

class CellTappedViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favArrayCore: [Resultss]?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: VC Lifecicle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: FavCell.nibName, bundle: nil), forCellWithReuseIdentifier: FavCell.nibName)
        
        fetchDataFromCoreData()
        
        
    }
    
    // MARK: Methods

    func fetchDataFromCoreData() {
        do {
            favArrayCore = try context.fetch(Resultss.fetchRequest())
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.collectionView.reloadData()
            }
        } catch {
            print("failed to fetch")
        }
        
    }
    
    // MARK: Actions

}

// MARK: Favorites collectionView

extension CellTappedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favArrayCore?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavCell.nibName, for: indexPath) as! FavCell
        

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width) / 2.2
        return CGSize(width: width, height: width)
    }
}
