//
//  ProfileViewController.swift
//  Timeline
//
//  Created by Cameron Moss on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit
import SafariServices

class ProfileViewController: UIViewController, UICollectionViewDataSource{
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var editBarButtonItem: UIBarButtonItem!
    
    var user: User?
    var userPosts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.user == nil {
            self.user = UserController.sharedController.currentUser
            editBarButtonItem.enabled = true
        }
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
        let headerCell =  collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "headerCell", forIndexPath: indexPath) as! ProfileHeaderCollectionReusableView
        if let user = user {
        headerCell.updateWithUser(user)
        }
        headerCell.delegate = self
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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "toEditProfile" {
            let destinationViewController = segue.destinationViewController as? LoginSignUpViewController
            
            _ = destinationViewController?.view
            if let user = user {
            destinationViewController?.updateWithUser(user)
            }
        }
    }
    

}
extension ProfileViewController: ProfileHeaderCollectionReusableViewDelegate {
    func userTappedURLButton() {
        if let user = user {
            let safariVC = SFSafariViewController(URL: NSURL(string: user.url ?? "")!)
            self.presentViewController(safariVC, animated: true, completion: nil)
        }
    }
    func userTappedFollowActionButton() {
        guard let user = user else { return }
        
        if user == UserController.sharedController.currentUser {
            
            UserController.logOutCurrentUser()
            
            tabBarController?.selectedViewController = tabBarController?.viewControllers![0]
            
        }else {
            UserController.userFollowsUser(UserController.sharedController.currentUser, user2: user, completion:{ (followsUser) -> Void in
                if followsUser {
                    UserController.unfollowUser(self.user!, completion: { (success) -> Void in
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.updateBasedOnUser()
                        })
                    })
                } else {
                    UserController.followUser(self.user!, completion: { (success) -> Void in
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.updateBasedOnUser()
                        })
                    })
                }
            })
            
            
        }
    }
}
