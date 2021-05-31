//
//  NewsViewController.swift
//  VKApp
//
//  Created by KKK on 19.04.2021.
//

import UIKit

class NewsViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var heightCell = 400.0
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "NewsTableViewCell")

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell
        else { return UITableViewCell() }
        
        
        
        cell.configate(frend: news[indexPath.item].frend,
                       headPost: news[indexPath.item].headPost,
                       datePost: news[indexPath.item].datePost,
                       textPost: news[indexPath.item].textPost,
                       imagePost: news[indexPath.item].imagePost
        )
        
                if news[indexPath.item].imagePost == nil {
                    heightCell = 210
                } else {
                    heightCell = 400
                }
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         
        return CGFloat(heightCell)
    }
    
}
