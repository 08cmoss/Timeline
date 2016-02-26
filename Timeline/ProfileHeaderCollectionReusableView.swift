//
//  ProfileHeaderCollectionReusableView.swift
//  Timeline
//
//  Created by Cameron Moss on 2/25/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit


class ProfileHeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var homepageButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    
    var delegate: ProfileHeaderCollectionReusableViewDelegate?
    
    @IBAction func urlButtonTapped(sender: AnyObject) {
        delegate?.userTappedURLButton()
    }
    
    
    @IBAction func followUserButtonTapped(sender: AnyObject) {
        delegate?.userTappedFollowActionButton()
    }
    
    
    
    func updateWithUser(user: User) {
        if user.bio != nil {
            bioLabel.text = user.bio
        } else {
            bioLabel.hidden = true
        }
        if user.url != nil {
            homepageButton.setTitle(user.url, forState: .Normal)
        } else {
            homepageButton.hidden = true
        }
        if user == UserController.sharedController.currentUser {
            followButton.setTitle("Logout", forState: .Normal)
        } else{
            followButton.hidden = false
            UserController.userFollowsUser(UserController.sharedController.currentUser, user2: user, completion: { (follows) -> Void in
                if follows {
                    self.followButton.setTitle("Unfollow", forState: .Normal)
                } else {
                    self.followButton.setTitle("Follow", forState: .Normal)
                }
            })
        }
    }
}

protocol ProfileHeaderCollectionReusableViewDelegate {
    func userTappedFollowActionButton ()
    func userTappedURLButton()
}

