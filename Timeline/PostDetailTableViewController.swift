//
//  PostDetailTableViewController.swift
//  Timeline
//
//  Created by Cameron Moss on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
   
    
    
    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateBasedOnPost()

    }


    // MARK: - Table view data source

   

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.post!.comments.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentDetailCell", forIndexPath: indexPath)

        let comment = post?.comments[indexPath.row]
        
        if let comment = comment {
            cell.textLabel?.text = comment.username
            cell.detailTextLabel?.text = comment.text
        }

        return cell
    }
    
    
    func updateBasedOnPost() {
        
        guard let post = post else { return }
        
        self.likesLabel.text = "\(post.likes.count) likes"
        self.commentsLabel.text = "\(post.comments.count) comments"
//        headerImageView.image = nil
        
        
        ImageController.imageForIdentifier(post.imageEndPoint) { (image) -> Void in
            self.headerImageView.image = image
        }
        
        tableView.reloadData()
    }
    
    @IBAction func likeTapped(sender: AnyObject) {
        guard let post = post else { return }
        PostController.addLikeToPost(post) { (success, post) -> Void in
            if let post = post {
                self.post = post
                self.updateBasedOnPost()
            }
        }
    }
    
    @IBAction func addCommentTapped(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Add Comment", message: nil, preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler { (textfield) -> Void in
            textfield.placeholder = "Comment"
        }
        
        alertController.addAction(UIAlertAction(title: "Add Comment", style: .Default, handler: { _ in
            if let text = alertController.textFields?.first?.text {
                PostController.addCommentWithTextToPost(text, post: self.post!, completion: { (success, post) -> Void in
                    if let post = post {
                        self.post = post
                        self.updateBasedOnPost()
                    }
                })
            }
        }))
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    

}
