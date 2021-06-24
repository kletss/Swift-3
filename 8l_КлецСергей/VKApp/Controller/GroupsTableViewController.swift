//
//  GroupsTableViewController.swift
//  VKApp
//
//  Created by KKK on 06.04.2021.
//

import UIKit
import RealmSwift
import FirebaseDatabase

class GroupsTableViewController: UITableViewController, UISearchBarDelegate {
    
//    var vkGroups = VKGroups(count: 0, items: []) {
//        didSet {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    private var vkGroups = try? RealmService.load(typeOf: RealmGroup.self)
    private var token: NotificationToken?
 
       var myGroups = [groupModel]()
       let animatorUp = PushAnimation1()
       let animatorDown = PopAnimation1()
    
    
    @IBOutlet weak var searcheBar: UISearchBar!
    var filteredGroups = [RealmGroup]()
    
    var isSearchBarEmpty: Bool {
      return searcheBar.text?.isEmpty ?? true
    }
    
    
    private let rtDatabase = Database.database().reference()

    
      @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard
            segue.identifier == "addGroup",
            let allGroupsTableViewController = segue.source as? AllGroupsTableViewController,
            let indexPath = allGroupsTableViewController.tableView.indexPathForSelectedRow
        else {
            return
        }
        var ind = allGroups[indexPath.row]
        if !allGroupsTableViewController.isSearchBarEmpty {
            ind = allGroupsTableViewController.filteredGroups[indexPath.row]
        }

            
        if !myGroups.contains(ind) {
            myGroups.append(ind)
            let index = IndexPath(row:  myGroups.count-1, section: 0)
            tableView.insertRows(at: [index], with: .automatic)
        }
    }
    
    @IBAction func addAllGroupView(_ sender: Any) {
//        let myAllGroupViewController = UIStoryboard(
//            name: "Main",
//            bundle: nil)
//            .instantiateViewController(withIdentifier: "AllGroupTableView")
//        myAllGroupViewController.transitioningDelegate = self
//        present(myAllGroupViewController, animated: true)
//
    }
    

    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredGroups = Array(vkGroups!)
        
        searcheBar.delegate = self
        
        observeRealmGroups()
        
        let nib = UINib(nibName: "GroupsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "GroupsTableViewCell")
        
        NetworkService().getListGroups() {
//            [weak self] realmGroups in
            realmGroups in
            do {
                try RealmService.save(items: realmGroups)
            } catch {
                print(error)
            }
            // коллекция должна прочитать новые данные
//           self?.tableView.reloadData()
         }
        
        
           loadSearcheDatabase()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        token?.invalidate()
        
        saveSearcheDatabase()
    }

    
    func loadSearcheDatabase() {
        self.rtDatabase.child("Searche").getData { error, snapshot in
            if snapshot.exists()  {
                    let valKey = snapshot.value! as? [String:String]
                    DispatchQueue.main.async {
                        let val = valKey!["Group"]
                        self.searcheBar.text = val
                        self.searcheBar.reloadInputViews()
                        self.searchBar(self.searcheBar, textDidChange: val ?? "")
                    }
            }
         }
    }

    
    func saveSearcheDatabase() {
//        vkGroups?.forEach { vkg in
//            rtDatabase.child(MySingletonSession.instance.userID).setValue(["ID":String(vkg.id),"name":vkg.name,"URL":vkg.photoAvatarURL])
//        }
        rtDatabase.child("Searche").setValue(["Group":searcheBar.text])
    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        var filter = "*"
        if !(searchText.isEmpty) {
            filter = "*\(searchText)*"
        }
        filteredGroups = Array(vkGroups!.filter(NSPredicate(format: "name LIKE '\(filter)'")))
        tableView.reloadData()
    }
    

    
    private func observeRealmGroups() {
        token = vkGroups?.observe({ changes in
            switch changes {
            case .initial(let results):
                if results.count > 0 {
                    self.tableView.reloadData()
                }
                
            case let .update(_, deletions, insertions, modifications):
                if !modifications.isEmpty {
                    var indexPath = [IndexPath]()
                    for item in modifications {
                        indexPath.append(IndexPath(row: item, section: 0))
                    }
                    self.tableView.reloadRows(at: indexPath, with: .automatic)
                }
                if !insertions.isEmpty {
                    var indexPath = [IndexPath]()
                    for item in insertions {
                        indexPath.append(IndexPath(row: item, section: 0))
                    }
                    self.tableView.insertRows(at: indexPath, with: .bottom)
                }
                if !deletions.isEmpty {
                        var indexPath = [IndexPath]()
                        for item in deletions {
                            indexPath.append(IndexPath(row: item, section: 0))
                        }
                        self.tableView.deleteRows(at: indexPath, with: .top)
                }
            case .error(let error):
                print(error)
            }
        })
    }
    
    
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsTableViewCell", for: indexPath) as? GroupsTableViewCell
        else { return UITableViewCell() }
//        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupsCell

// //      cell.textLabel?.text = myGroups[indexPath.item].name
// //       cell.imageView?.image = myGroups[indexPath.item].image
        cell.configate(imageUrl: filteredGroups[indexPath.item].photoAvatarURL,
                       name: filteredGroups[indexPath.item].name)

        return cell
    }
    
    // MARK: - Table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // table
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            myGroups.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//    }
    
}

// 
extension GroupsTableViewController: UIViewControllerTransitioningDelegate {
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animatorUp
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animatorDown
    }
}
