//
//  GroupsTableViewController.swift
//  VKApp
//
//  Created by KKK on 06.04.2021.
//

import UIKit

class GroupsTableViewController: UITableViewController {
    
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
        
        let nib = UINib(nibName: "GroupsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "GroupsTableViewCell")
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsTableViewCell", for: indexPath) as? GroupsTableViewCell
        else { return UITableViewCell() }
//        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupsCell

// //      cell.textLabel?.text = myGroups[indexPath.item].name
// //       cell.imageView?.image = myGroups[indexPath.item].image
        
        cell.configate(image: myGroups[indexPath.item].image, name: myGroups[indexPath.item].name)

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
