//
//  GroupsTableViewController.swift
//  VKApp
//
//  Created by KKK on 06.04.2021.
//

import UIKit
import RealmSwift

class GroupsTableViewController: UITableViewController {
    
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
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        token?.invalidate()
    }
    
    private func observeRealmGroups() {
        token = vkGroups?.observe({ changes in
            switch changes {
            case .initial(let results):
                if results.count > 0 {
                    self.tableView.reloadData()
                }
                
            case let .update(results, deletions, insertions, modifications):
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
        return vkGroups?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsTableViewCell", for: indexPath) as? GroupsTableViewCell
        else { return UITableViewCell() }
//        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupsCell

// //      cell.textLabel?.text = myGroups[indexPath.item].name
// //       cell.imageView?.image = myGroups[indexPath.item].image
        cell.configate(imageUrl: vkGroups![indexPath.item].photoAvatarURL,
                       name: vkGroups![indexPath.item].name)

        return cell
    }
    
    // MARK: - Table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // table
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
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
