//
//  PhotoCellView.swift
//  Flicker App
//
//  Created by Tatiana Podlesnykh on 18.2.2021.
//

import UIKit

class PhotoCellView: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
            
        img.clipsToBounds = true
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 10
    }
    
}
