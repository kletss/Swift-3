//
//  FrendsViewController.swift
//  VKApp
//
//  Created by KKK on 14.04.2021.
//

import UIKit

class FrendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var vkFriends = VKFriends(count: 0, items: [])
    
//    var frends = [frendsSections]()
//    var lettersSection = [Character]()
//
//
    override func viewDidLoad() {
        super.viewDidLoad()
        

        NetworkService().getListFriends() {
            [weak self] vkFriends in self?.vkFriends = vkFriends
            self?.FrandsTableView.reloadData()
         }
        // Do any additional setup after loading the view.
              
//       view.addSubview(frendsController)
        self.FrandsTableView.reloadData()
    }
    
    
    
//    lazy var frendsController = VKApp.FrendsController(letters: lettersSection,
//                                                       frame: CGRect(x: FrendsController.frame.minX-25, y: FrendsController.frame.minY,
//                                                      width: 25,
//                                                      height: 250))
 
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - Table view data source
   @IBOutlet var FrandsTableView: UITableView!

    @IBOutlet weak var FrendsController: FrendsController!
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return vkFriends.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return frends[section].rows.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FrendsCell_Ind", for: indexPath) as! FrendsCell
//        cell.textLabel?.text = frends[indexPath.item].nik
//        cell.imageView?.image = frends[indexPath.item].image
//        cell.accessoryType = .disclosureIndicator
//
        
//        cell.configate(image: frends[indexPath.item].image, nik: frends[indexPath.item].nik+" "+section)
//        print(indexPath.section)
//        cell.configate(image: frends[indexPath.section].rows[indexPath.row].image, nik: frends[indexPath.section].rows[indexPath.row].nik)
        
       
        cell.configate(imageUrl: vkFriends.items[indexPath.row].userAvatarURL,
                       nik: vkFriends.items[indexPath.row].fullName
        )
        
        return cell
    }
    
    // MARK: - Table view delegate methods
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Передача данных в FrendCollectionViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "presentFrendCollection" else { return }
        guard let destination = segue.destination as? FrendCollectionViewController else { return }
        let ind = FrandsTableView.indexPathForSelectedRow
//        print(frends[ind!.section].rows[ind!.row].id)
      //  destination.frend.append(frends[ind!.item])
      //  destination.frend.append(frends[ind!.section].rows[ind!.row])
//        destination.frendIndex = frends[ind!.section].rows[ind!.row].id
        destination.frendIndex = vkFriends.items[ind!.row].id
    }
    
    // Create a custom header
//    override func tableView(_ tableView: UITableView,
//            viewForHeaderInSection section: Int) -> UIView? {
//       let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
//                   "sectionHeader") as! MyCustomHeader
//       view.title.text = sectionLetter[section]
//   //    view.image.image = UIImage(named: sectionImages[section])
//
//       return view
//    }
    
    // Create a standard header that includes the returned text.
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
////        return   String(frends[section].section)
//        return   String(vkFriends[section].section)
//    }
    
    
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return lettersSection.map{ "\($0)" }
//    }
    
}
