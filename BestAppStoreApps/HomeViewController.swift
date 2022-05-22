//
//  HomeViewController.swift
//  BestAppStoreApps
//
//  Created by Guy Twig on 24/04/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
// MARK: Properties
    
    var freeAppsArray: [Results] = []
    var paidAppsArray: [Results] = []
    var favArray: [Results] = []
    var cellHeight = 80.0
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context = appDelegate.persistentContainer.viewContext
    
// MARK: Outlets
    
    @IBOutlet weak var carouselView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var freeLoader: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var paidLoader: UIActivityIndicatorView!
    
// MARK: VC Lifecicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionAndTableViews()
        paidLoader.startAnimating()
        getPaid()
        freeLoader.startAnimating()
        getFreeApps()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let fav = UserDefaults.standard.favListSave {
            favArray = fav
        }
        collectionView.reloadData()
        tableView.reloadData()
    }
    
// MARK: Methods
    
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

// MARK: Free Apps collectionView

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
        cell.isFav = favArray.contains(where: {$0.name == freeAppsArray[indexPath.row].name})
        if cell.isFav {
            cell.favoriteImage.image = (UIImage(named: "purple_heart"))
        } else {
            cell.favoriteImage.image = (UIImage(named: "empty_heart"))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CellTapViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width) / 1.5
        return CGSize(width: width, height: width)
    }
}

extension HomeViewController: FreeCellDelegate {
    func passDataFree(index: Int, remove: Bool) {
        if remove {
            if favArray.contains(where: {$0.name == freeAppsArray[index].name}) {
                let filteredArr  = favArray.filter({$0.name != freeAppsArray[index].name})
                favArray = filteredArr
                UserDefaults.standard.favListSave = favArray
            }
        } else {
            if !favArray.contains(where: {$0.name == freeAppsArray[index].name}) {
                favArray.append(freeAppsArray[index])
                UserDefaults.standard.favListSave = favArray
            }
        }
    }
}

// MARK: Paid Apps tableView

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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CellTapViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cellHeight
    }
}

extension HomeViewController: PaidCellDelegate {
    func passDataPaid(index: Int, remove: Bool) {
        if remove {
            if favArray.contains(where: {$0.name == paidAppsArray[index].name}) {
                let filtered  = favArray.filter({$0.name != paidAppsArray[index].name})
                favArray = filtered
                UserDefaults.standard.favListSave = favArray
            }
        } else {
            if !favArray.contains(where: {$0.name == paidAppsArray[index].name}) {
                favArray.append(paidAppsArray[index])
                UserDefaults.standard.favListSave = favArray
            }
        }
    }
}

