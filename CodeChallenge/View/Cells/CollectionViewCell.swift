//
//  CollectionViewCell.swift
//  CodeChallenge
//
//  Created by Fabrizio Prosperi on 26/02/2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    override func prepareForReuse() {
        imageView?.image = nil
        imageView?.cancelLoadImage()
    }

    
    @IBOutlet weak var imageView: UIImageView!
    
    func setup(with url: URL) {
        imageView.loadImage(at: url)
    }
    
}
