//
//  RealmFrends.swift
//  VKApp
//
//  Created by KKK on 01.06.2021.
//

import UIKit
import RealmSwift

class RealmFrends: Object {
    @objc dynamic var id: Int = 0
    let frends = List<RealmUser>()
       
    override static func primaryKey() -> String? {
        return "id"
    }

}
