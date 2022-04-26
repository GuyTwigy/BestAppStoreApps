//
//  FavCell.swift
//  BestAppStoreApps
//
//  Created by Guy Twig on 26/04/2022.
//

import UIKit

protocol FavCellDelegate {
    func updateFavArray(favArray: [Results])
}

class FavCell: UICollectionViewCell {

    static let nibName = "FavCell"
    var favArray: [Results] = []
    var index = Int()
    var delegate: FavCellDelegate?
    
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appImageView: UIImageView!
    
    
    func updateCellContent() {
        appName.text = favArray[index].name
        appImageView.image = UIImage(url: URL(string: favArray[index].artworkUrl100))
    }
    
    
    @IBAction func remove(_ sender: UIButton) {
        favArray.remove(at: index)
        UserDefaults.standard.favListSave = favArray
        delegate?.updateFavArray(favArray: favArray)
    }
}