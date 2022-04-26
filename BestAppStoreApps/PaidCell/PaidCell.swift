//
//  PaidCell.swift
//  BestAppStoreApps
//
//  Created by Guy Twig on 26/04/2022.
//

import UIKit

protocol PaidCellDelegate {
    func passData(favArray: [Results], index: Int, remove: Bool)
}

class PaidCell: UITableViewCell {
    
    static let nibName = "PaidCell"
    var paidArray: [Results] = []
    var favArray: [Results] = []
    var index = Int()
    var isFavorite = false
    var delegate: PaidCellDelegate?
    
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var buttonImageView: UIImageView!
    
    func updateCellContent() {
        appName.text = paidArray[index].name
        appImageView.image = UIImage(url: URL(string: paidArray[index].artworkUrl100))
        if isFavorite {
            buttonImageView.image = (UIImage(named: "purple_heart"))
        } else {
            buttonImageView.image = (UIImage(named: "empty_heart"))
        }
    }
    
    func animationForFavotite() {
        UIView.animate(withDuration: 1, delay: 0.1, options: .curveEaseOut, animations: {
            self.buttonImageView.image = (UIImage(named: "purple_heart"))
            self.buttonImageView.transform = CGAffineTransform(rotationAngle: .pi)
        }) { _ in
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
                self.buttonImageView.alpha = 0.1
                self.buttonImageView.transform = .identity
            }) { _ in
                UIView.animate(withDuration: 1.5, delay: 1, options: .curveEaseIn, animations: {
                    self.buttonImageView.alpha = 1
                    self.buttonImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                }) { _ in
                    UIView.animate(withDuration: 1.5, delay: 1, options: .curveEaseIn, animations: {
                        self.buttonImageView.transform = .identity
                    })
                }
            }
        }
    }
    
    @IBAction func favoriteTapped(_ sender: Any) {
        if isFavorite {
            delegate?.passData(favArray: favArray, index: index, remove: true)
        } else {
            animationForFavotite()
            delegate?.passData(favArray: favArray, index: index, remove: false)
        }
    }
}

