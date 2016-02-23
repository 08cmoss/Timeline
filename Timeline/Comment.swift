//
//  Comment.swift
//  Timeline
//
//  Created by Cameron Moss on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct Comment: Equatable {
    
    var username: String
    var text: String
    var postIdentifier: String
    var identifier: String?
    
    init(username: String, text: String, postIdentifier: String, identifier: String?) {
        self.username = username
        self.text = text
        self.postIdentifier = postIdentifier
        self.identifier = nil
    }
}

func ==(lhs: Comment, rhs: Comment) -> Bool {
    return (lhs.username == rhs.username && lhs.identifier == rhs.identifier)
}

















//Create a Comment.swift file and define a new Comment struct.
//Add properties for username, text, postIdentifier, and optional identifier.
//Add a memberwise initializer that takes parameters for each property
//Set a default parameter nil for optional properties
//Implement the Equatable protocol by comparing bolth the usernames and identifiers.