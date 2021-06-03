//
//  RealmUser.swift
//  VKApp
//
//  Created by KKK on 01.06.2021.
//

import UIKit
import RealmSwift

class RealmUser: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var fullName: String  { "\(firstName)  \(lastName)" }
    @objc dynamic var idPhotoAvatar: Data? = nil
    let photos = List<RealmPhotos>()
    let groups = List<RealmGroups>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    override static func indexedProperties() -> [String] {
        return ["fullName"]
    }
}


/*
 struct VKUser {
     let id: Int
     let firstName: String
     let lastName: String
     var fullName: String  { "\(firstName)  \(lastName)" }
     let userAvatarURL: String

 }
 */

