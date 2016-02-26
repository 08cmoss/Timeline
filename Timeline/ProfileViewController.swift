//
//  ProfileViewController.swift
//  Timeline
//
//  Created by Cameron Moss on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var user: User?
    var userPosts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(user)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPosts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let postCell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        let post = userPosts[indexPath.item]
        postCell.updateWithImageIdentifier(post.identifier ?? "")
        return postCell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerCell =  collectionView.dequeueReusableSupplementaryViewOfKind("ProfileHeaderCollectionReusableView", withReuseIdentifier: "headerCell", forIndexPath: indexPath) as! ProfileHeaderCollectionReusableView
        if let user = user {
        headerCell.updateWithUser(user)
        }
        return headerCell
    }
    
    
    
    func updateBasedOnUser() {
        self.title = user?.username
        if let user = user {
        PostController.fetchTimelineForUser(user) { (results) -> Void in
            self.userPosts = results
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.collectionView.reloadData()
            })
            
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
