//
//  FrendCollectionViewCell.swift
//  VKApp
//
//  Created by KKK on 06.04.2021.
//

import UIKit

class FrendCollectionViewCell: UICollectionViewCell {
    

   @IBOutlet weak var imageView: UIImageView!

    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        
    }
    func configate(frend: UIImage) {
        

        imageView.image = frend
    }
    
}
