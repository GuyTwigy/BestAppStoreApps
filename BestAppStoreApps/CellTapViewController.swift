//
//  CellTapViewController.swift
//  BestAppStoreApps
//
//  Created by Guy Twig on 15/05/2022.
//

import Foundation
import UIKit

class CellTapViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favArrayCore: [ResultCoreData]?
    var favPresons: [Person] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: VC Lifecicle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: FavCell.nibName, bundle: nil), forCellWithReuseIdentifier: FavCell.nibName)
        
        do {
            try context.save()
            print("shaked saved")
        } catch {
            print("error")
        }
        fetchDataFromCoreData()
    }
    
    // MARK: Methods

    func fetchDataFromCoreData() {
        do {
            favPresons = try context.fetch(Person.fetchRequest())
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }

                self.collectionView.reloadData()
                print(self.favPresons)
            }
        } catch {
            print("failed to fetch")
        }
//        do {
//            favArrayCore = try context.fetch(ResultCoreData.fetchRequest())
//            DispatchQueue.main.async { [weak self] in
//                guard let self = self else {
//                    return
//                }
//
//                self.collectionView.reloadData()
//            }
//        } catch {
//            print("failed to fetch")
//        }
    }
    
    // MARK: Actions

}

// MARK: Favorites collectionView

extension CellTapViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favPresons.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavCell.nibName, for: indexPath) as! FavCell
        
        cell.appName.text = favPresons[indexPath.row].name
        

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width) / 2.2
        return CGSize(width: width, height: width)
    }
}
