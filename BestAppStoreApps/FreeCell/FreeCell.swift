//
//  FreeCell.swift
//  BestAppStoreApps
//
//  Created by Guy Twig on 26/04/2022.
//

import UIKit

protocol FreeCellDelegate {
    func passDataFree(index: Int, remove: Bool)
}

class FreeCell: UICollectionViewCell {

// MARK: Properties & Outlets
    
    static let nibName = "FreeCell"
    var freeArray: [Results] = []
    var favArray: [Results] = []
    var index = Int()
    var isFav = false
    var delegate: FreeCellDelegate?
    
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appImage: UIImageView!
    
    
// MARK: Methods
    
    func updateCellContent() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(favTapped))
        favoriteImage.addGestureRecognizer(tap)
        
        appName.text = freeArray[index].name
        appImage.image = UIImage(url: URL(string: freeArray[index].artworkUrl100))
    }
    
    func animationForFavotite() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.favoriteImage.image = (UIImage(named: "purple_heart"))
            self.favoriteImage.transform = CGAffineTransform(rotationAngle: .pi)
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.favoriteImage.transform = .identity
            }) { _ in
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                    self.favoriteImage.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                }) { _ in
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                        self.favoriteImage.transform = .identity
                    })
                }
            }
        }
    }

// MARK: Actions
    
    @objc func favTapped() {
        if isFav {
            favoriteImage.image = UIImage(named: "empty_heart")
            delegate?.passDataFree(index: index, remove: true)
        } else {
            animationForFavotite()
            delegate?.passDataFree(index: index, remove: false)
        }
        isFav = !isFav
    }
    
}
