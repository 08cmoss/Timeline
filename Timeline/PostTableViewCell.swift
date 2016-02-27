//
//  PostTableViewCell.swift
//  Timeline
//
//  Created by Cameron Moss on 2/26/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateWithPost(post: Post) {
        likesLabel.text = "Likes \(post.likes.count)"
        commentsLabel.text = "Comments \(post.comments.count)"
        postImageView.image = nil
        
        ImageController.imageForIdentifier(post.imageEndPoint) { (image) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
              self.postImageView.image = image 
            })
        }
    }

}
