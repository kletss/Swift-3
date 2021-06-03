//
//  FrendsCell.swift
//  VKApp
//
//  Created by KKK on 05.04.2021.
//

import UIKit

class FrendsCell: UITableViewCell {

    var avatar: UIImage = UIImage(named: "noneAvatarFriend")!

    let av = AvatarAnimate()
    
    @IBAction func buttonImage(_ sender: Any) {
        av.avatarAnimate(self.frendAvatar)
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        frendName.text = nil
//        frendAvatar.image = nil
//    }
    
    @IBOutlet weak var frendAvatar: UIImageView!
    @IBOutlet weak var frendName: UILabel!

    func configate(imageUrl: String, nik: String ) {
        
        guard let url = URL(string: imageUrl) else { return } 
        if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                        self.avatar = image
                }
            }

        
        frendName.text = nik
        frendAvatar.image = avatar
    }

}
