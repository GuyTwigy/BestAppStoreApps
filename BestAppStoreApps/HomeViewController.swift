//
//  HomeViewController.swift
//  BestAppStoreApps
//
//  Created by Guy Twig on 24/04/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    var freeAppsArray: [Results] = []
    var paidAppsArray: [Results] = []
    var favArray: [Results] = []
    var cellHeight = 80.0
    
    @IBOutlet weak var carouselView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var freeLoader: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var paidLoader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionAndTableViews()
        paidLoader.startAnimating()
        getPaid()
        freeLoader.startAnimating()
        getFreeApps()
    }
    
    func setUpCollectionAndTableViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: FreeCell.nibName, bundle: nil), forCellWithReuseIdentifier: FreeCell.nibName)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: PaidCell.nibName, bundle: nil), forCellReuseIdentifier: PaidCell.nibName)
    }
    
    func getFreeApps() {
        NetworkManager.shared.getFreeApps { result, freeAppResponse in
            guard let response = freeAppResponse else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.freeAppsArray = response
                self.collectionView.reloadData()
                self.freeLoader.stopAnimating()
            }
        }
    }
    
    func getPaid() {
        NetworkManager.shared.getPaidApps { result, paid in
            guard let paid = paid else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.paidAppsArray = paid
                self.tableView.reloadData()
                self.paidLoader.stopAnimating()
            }
        }
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        freeAppsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FreeCell.nibName, for: indexPath) as! FreeCell
        cell.freeArray = freeAppsArray
        cell.index = indexPath.row
        cell.updateCellContent()
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width) / 1.5
        return CGSize(width: width, height: width)
    }
}

extension HomeViewController: FreeCellDelegate {
    func passDataFree(favArray: [Results], index: Int, remove: Bool) {
        self.favArray = favArray
        if remove {
            if favArray.contains(where: {$0.name == paidAppsArray[index].name}) {
                let filtered  = favArray.filter({$0.name != paidAppsArray[index].name})
                self.favArray = filtered
                UserDefaults.standard.favListSave = self.favArray
            }
        } else {
            if !favArray.contains(where: {$0.name == paidAppsArray[index].name}) {
                self.favArray.append(paidAppsArray[index])
                UserDefaults.standard.favListSave = self.favArray
            }
        }
    }
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        paidAppsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaidCell.nibName, for: indexPath) as! PaidCell
        cell.paidArray = paidAppsArray
        cell.index = indexPath.row
        cell.updateCellContent()
        cell.delegate = self
        cell.isFavorite = favArray.contains(where: {$0.name == paidAppsArray[indexPath.row].name})
        if cell.isFavorite {
            cell.buttonImageView.image = (UIImage(named: "purple_heart"))
        } else {
            cell.buttonImageView.image = (UIImage(named: "empty_heart"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cellHeight
    }
}

extension HomeViewController: PaidCellDelegate {
    func passDataPaid(favArray: [Results], index: Int, remove: Bool) {
        self.favArray = favArray
        if remove {
            if favArray.contains(where: {$0.name == paidAppsArray[index].name}) {
                let filtered  = favArray.filter({$0.name != paidAppsArray[index].name})
                self.favArray = filtered
                UserDefaults.standard.favListSave = self.favArray
            }
        } else {
            if !favArray.contains(where: {$0.name == paidAppsArray[index].name}) {
                self.favArray.append(paidAppsArray[index])
                UserDefaults.standard.favListSave = self.favArray
            }
        }
    }
}

