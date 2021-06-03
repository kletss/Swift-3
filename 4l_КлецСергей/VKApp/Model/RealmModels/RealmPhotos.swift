//
//  RealmPhotos.swift
//  VKApp
//
//  Created by KKK on 01.06.2021.
//

import UIKit
import RealmSwift

class RealmPhotos: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var photo: Data? = nil
//    @objc dynamic var owner_id: Int  = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
//    override static func indexedProperties() -> [String] {
//        return ["owner_id"]
//    }
}
