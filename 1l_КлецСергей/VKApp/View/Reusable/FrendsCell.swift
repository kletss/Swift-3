//
//  FrendsCell.swift
//  VKApp
//
//  Created by KKK on 05.04.2021.
//

import UIKit

class FrendsCell: UITableViewCell {

    let av = AvatarAnimate()
    
    @IBAction func buttonImage(_ sender: Any) {
        av.avatarAnimate(self.frendAvatar)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        frendName.text = nil
        frendAvatar.image = nil
    }
    
    @IBOutlet weak var frendAvatar: UIImageView!
    @IBOutlet weak var frendName: UILabel!

    func configate(image: UIImage, nik: String ) {
        
        frendName.text = nik
        frendAvatar.image = image
    }

}
