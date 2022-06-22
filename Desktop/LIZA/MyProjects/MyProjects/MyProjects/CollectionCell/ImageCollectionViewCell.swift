//
//  ImageCollectionViewCell.swift
//  MyProjects
//
//  Created by Vik Holovach on 02.06.2022.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var moneyImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.borderView.layer.borderColor = UIColor.lightGray.cgColor
        self.borderView.layer.borderWidth = 2
        self.borderView.layer.cornerRadius = 5
    }

}
