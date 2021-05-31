//
//  NetworkService.swift
//  VKApp
//
//  Created by KKK on 23.05.2021.
//

import UIKit
 
class NetworkService {
    
    private static let apiVersion = "5.131"
    
    private var urlComponents : URLComponents = {
        var myUrl = URLComponents ()
        myUrl.scheme = "https"
        myUrl.host = "api.vk.com"
        myUrl.path = "/method"
        myUrl.queryItems = [
            URLQueryItem(name: "access_token", value: MySingletonSession.instance.token),
            URLQueryItem(name: "v", value: apiVersion),
        ]
        return myUrl
    } ()
    
//    ------------------
    func getListFriendsS(user_ID userID: String = MySingletonSession.instance.userID, completion: @escaping (VKFriends) -> Void)  {
        var myUrl = urlComponents
        myUrl.path = "/method/friends.get"
        myUrl.queryItems?.append(contentsOf:[
                                        URLQueryItem(name: "user_id", value: userID),
                                        URLQueryItem(name: "fields", value: "photo_200"),
                                        ])

        let url = myUrl.url  //{
            print("url= \(String(describing: url))")
            
        let session = URLSession(configuration: URLSessionConfiguration.default)
            session.dataTask(with: url!) { (data, response, error) in
                guard let JSONData = data else {return}
                let vkFriends = try? JSONDecoder().decode(VKResponse<VKFriends>.self, from: JSONData)
                guard let vkF1 = vkFriends?.response else {return}
                completion(vkF1)
          }
        .resume()

    }
  
//    ------------
    
    func getListFriends(user_ID userID: String = MySingletonSession.instance.userID) -> VKFriends {
        var vkF : VKFriends = VKFriends(count: 0,items: [])
         
        var myUrl = urlComponents
        myUrl.path = "/method/friends.get"
        myUrl.queryItems?.append(contentsOf:[
                                        URLQueryItem(name: "user_id", value: userID),
                                        URLQueryItem(name: "fields", value: "photo_200"),
                                        ])

        let url = myUrl.url  //{
            print("url= \(String(describing: url))")
            
        let session = URLSession(configuration: URLSessionConfiguration.default)
            session.dataTask(with: url!) { (data, response, error) in
                guard let JSONData = data else {return}
                let vkFriends = try? JSONDecoder().decode(VKResponse<VKFriends>.self, from: JSONData)
                guard let vkF1 = vkFriends?.response else {return}
                vkF = vkF1
//                if let JSONData = data {

    //                let json = try? JSONSerialization.jsonObject(
    //                    with: JSONData,
    //                    options: .allowFragments )
    //                print("json= \(String(describing: json)) ")
                    
//                    let vkFriends = try? JSONDecoder().decode(VKResponse<VKFriends>.self, from: JSONData)
//                    guard let vkF1 = vkFriends?.response else {return}
            
//                }
          }
        .resume()
//        }
        return vkF
    }
    

    func getListGroups(completion: @escaping (VKGroups) -> Void) {
        var myUrl = urlComponents
        myUrl.path = "/method/groups.get"
        myUrl.queryItems?.append(contentsOf:[
                                        URLQueryItem(name: "extended", value: "1"),
//                                        URLQueryItem(name: "count", value: "1"),
                                        ])
        if let url = myUrl.url {
        print("url= \(url)")
        
        
//        let session = URLSession.shared
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: url) { (data, response, error) in
//            guard error == nil else {
//                // error parsing
//                return
//            }
            
            if let JSONData = data {
//                let json = try? JSONSerialization.jsonObject(
//                    with: JSONData,
//                    options: .allowFragments)
//                print("json \(json) ")

                    let vkGroups = try? JSONDecoder().decode(VKResponse<VKGroups>.self, from: JSONData)
//                    print(vkGroups)
                guard let vkG = vkGroups?.response else {return}
                completion(vkG)
            }
        }
        .resume()
      }
   }
    
    
    func getPhotos(user_ID userID : String = MySingletonSession.instance.userID, completion: @escaping (VKPhotos) -> Void) {
        var myUrl = urlComponents
        myUrl.path = "/method/photos.getAll"
        myUrl.queryItems?.append(contentsOf:[
                                            URLQueryItem(name: "user_id", value: userID),
                                            URLQueryItem(name: "extended", value: "1"),
        ])
        if let url = myUrl.url {
        print("url= \(url)")
            let session = URLSession(configuration: URLSessionConfiguration.default)
            session.dataTask(with: url) { (data, response, error) in
                if let JSONData = data {
                    let vkPhotos = try? JSONDecoder().decode(VKResponse<VKPhotos>.self, from: JSONData)
//                    print(vkPhotos)
                    guard let vkP = vkPhotos?.response else {return}
                    completion(vkP)
                }
            }
            .resume()
        }
    }
    
    func getUserInfoURL(user_ID userID : String = MySingletonSession.instance.userID) -> URLComponents {
        var myUrl = urlComponents
        myUrl.path = "/method/users.get"
        myUrl.queryItems?.append(contentsOf: [URLQueryItem(name: "user_id", value: userID)])
        return myUrl
    }
    
}
 
