//
//  NetworkService.swift
//  VKApp
//
//  Created by KKK on 23.05.2021.
//

import UIKit
 
class NetworkService {
    
    private static let apiVersion = "5.126"
    
    private var urlComponents : URLComponents = {
        var url = URLComponents ()
        url.scheme = "https"
        url.host = "api.vk.com"
        url.path = "/method"
        url.queryItems = [
            URLQueryItem(name: "access_token", value: MySingletonSession.instance.token),
            URLQueryItem(name: "v", value: apiVersion),
        ]
        return url
    } ()
    
    
    func getListFriends(user_ID userID: String = MySingletonSession.instance.userID) {
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems?.append(contentsOf:[
                                        URLQueryItem(name: "user_id", value: userID),
                                        URLQueryItem(name: "fields", value: "photo_200"),
                                        ])
        let url = urlComponents.url
        print("url= \(String(describing: url))")
        
        
//        let session = URLSession.shared
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let fTask = session.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let JSONData = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(
                    with: JSONData,
                    options: .allowFragments )
                print("json= \(json) ")
            } catch {
                print(error)
            }
 
        }
        
        fTask.resume()
    }
    

    func getListGroups() {
        urlComponents.path = "/method/groups.get"
        
        let url = urlComponents.url
        print("url= \(String(describing: url))")
        
        
//        let session = URLSession.shared
        let session = URLSession(configuration: URLSessionConfiguration.default)

        
        let gTask = session.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                // error parsing
                return
            }
            
            guard let JSONData = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(
                    with: JSONData,
                    options: .allowFragments)
                print("json \(json) ")
            } catch {
                print(error)
            }
 
        }
        
        gTask.resume()
    }
    
    
    func getUserInfoURL(user_ID userID : String = MySingletonSession.instance.userID) -> URLComponents {
        urlComponents.path = "/method/users.get"
        urlComponents.queryItems?.append(contentsOf: [URLQueryItem(name: "user_id", value: userID)])
        return urlComponents
    }
    
}
 
