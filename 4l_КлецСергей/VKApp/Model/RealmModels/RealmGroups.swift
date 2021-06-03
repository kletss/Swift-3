//
//  RealmGroups.swift
//  VKApp
//
//  Created by KKK on 01.06.2021.
//

import UIKit
import RealmSwift

class RealmGroups: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }

}
