//
//  Post.swift
//  Timeline
//
//  Created by Cameron Moss on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct Post: Equatable {
    
    var imageEndPoint: String
    var caption: String?
    var username: String
    var comments: [Comment]
    var likes: [Like]
    var identifier: String?
    
    init(imageEndPoint: String, caption: String?, username: String, comments: [Comment], likes: [Like], identifier: String?) {
        
        self.imageEndPoint = imageEndPoint
        self.caption = nil
        self.username = username
        self.comments = []
        self.likes = []
        self.identifier = identifier
        
    }
    
    
}
func ==(lhs: Post, rhs: Post) -> Bool {
    return (lhs.username == rhs.username && lhs.identifier == rhs.identifier)
}







//Create a Post.swift file and define a new Post struct.
//Add properties for imageEndPoint, caption, username, comments, likes, and optional identifier.
//note: Since a Post can exist without a caption, caption is an optional property.
//Add a memberwise initializer that takes parameters for each property.
//    Set a default parameter nil for optional properties, and empty arrays for the commments and likes.
//Implement the Equatable protocol by comparing both the usernames and identifiers.