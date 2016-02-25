//
//  UserSearchTableViewController.swift
//  Timeline
//
//  Created by Cameron Moss on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class UserSearchTableViewController: UITableViewController {
    
    var usersDataSource: [User] = []
    
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    
    enum ViewMode: Int {
        case Friends = 0
        case All = 1
        
        func users(completion: (users: [User]?) -> Void) {
            switch self {
            case .Friends:
                UserController.followedByUser(UserController.sharedController.currentUser!, completion: { (users) -> Void in
                    guard let users = users else { return }
                    completion(users: users)
                })
            case .All:
                return UserController.fetchAllUsers({ (user) -> Void in
                    completion(users: user)
                })
            }
        }
    }
    
    var mode: ViewMode {
        get {
            return ViewMode(rawValue: modeSegmentedControl.selectedSegmentIndex)!
        }
    }
    
    func updateViewBasedOnMode() {
        mode.users { (users) -> Void in
            self.usersDataSource = users ?? []
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViewBasedOnMode()
    }
    
    
    @IBAction func selectedIndexChanged(sender: AnyObject) {
        
        updateViewBasedOnMode()
    }


    // MARK: - Table view data source



    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usersDataSource.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath)

        let user = usersDataSource[indexPath.row]
        
        cell.textLabel?.text = user.username

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
