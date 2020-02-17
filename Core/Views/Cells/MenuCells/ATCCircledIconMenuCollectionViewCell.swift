//
//  ATCCircledIconMenuCollectionViewCell.swift
//  DashboardApp
//
//  Created by Florian Marcu on 8/4/18.
//  Copyright © 2018 Instamobile. All rights reserved.
//

import UIKit

class ATCCircledIconMenuCollectionViewCell: UICollectionViewCell, MenuItemCollectionViewCellProtocol {
    @IBOutlet var menuImageView: UIImageView!
    @IBOutlet var menuLabel: UILabel!
    @IBOutlet var imageContainerView: UIView!
    
    func configure(item: NavigationItem) {
        menuImageView.image = item.image
        menuLabel.text = item.title

        imageContainerView.layer.cornerRadius = 30 / 2
        imageContainerView.layer.borderColor = UIColor.gray.darkModed.cgColor
        imageContainerView.layer.borderWidth = 1.0
        imageContainerView.backgroundColor = UIColor.white.darkModed
    }
}
