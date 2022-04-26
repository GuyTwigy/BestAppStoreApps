//
//  FreeCell.swift
//  BestAppStoreApps
//
//  Created by Guy Twig on 26/04/2022.
//

import UIKit

protocol FreeCellDelegate {
    func passDataFree(favArray: [Results], index: Int, remove: Bool)
}

class FreeCell: UICollectionViewCell {

    static let nibName = "FreeCell"
    var freeArray: [Results] = []
    var favArray: [Results] = []
    var index = Int()
    var isFav = false
    var delegate: FreeCellDelegate?
    
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appImage: UIImageView!
    
    
    func updateCellContent() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(favTapped))
        favoriteImage.addGestureRecognizer(tap)
        
        appName.text = freeArray[index].name
        appImage.image = UIImage(url: URL(string: freeArray[index].artworkUrl100))
    }
    
    @objc func favTapped() {
        if isFav {
            favoriteImage.image = UIImage(named: "empty_heart")
            delegate?.passDataFree(favArray: favArray, index: index, remove: true)
        } else {
            favoriteImage.image = UIImage(named: "purple_heart")
            delegate?.passDataFree(favArray: favArray, index: index, remove: false)
        }
        isFav = !isFav
    }
    
}
