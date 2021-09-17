//
//  ImageCollectionViewCell.swift
//  Sary
//
//  Created by hammam abdulaziz on 10/02/1443 AH.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    static let identifier = "ImageCollectionViewCell"
    
    var image: String?{
        didSet{
            imageView.load(with: image)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
