//
//  VKPhotos.swift
//  VKApp
//
//  Created by KKK on 28.05.2021.
//

struct VKImage {
    let urlImage: String
}


extension VKImage: Codable {
    enum CodingKeys: String, CodingKey {
        case urlImage = "url"
    }
}

struct VKLikes {
    let count: Int
}


extension VKLikes: Codable {
    enum CodingKeys: String, CodingKey {
        case count = "count"
    }
}

struct VKPhoto: Codable {
    let id: Int
    let date: Int
    let sizes: [VKImage]
    let likes: VKLikes
}


//extension VKPhoto: Codable {
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case date = "date"
//        case sizes = "sizes"
//        case likes = "likes"
//    }
//}


struct VKPhotos: Codable {
    let count: Int
    let items: [VKPhoto]
}
