//
//  Comment.swift
//  Timeline
//
//  Created by Cameron Moss on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct Comment: Equatable, FirebaseType {
    
    private let postKey = "post"
    private let usernameKey = "username"
    private let textKey = "text"
    var endpoint: String {
        return "/posts/\(self.postIdentifier)/comments/"
    }
    var jsonValue: [String: AnyObject] {
        return [textKey: text, postKey: postIdentifier, usernameKey: username]
    }
    
    var username: String
    var text: String
    var postIdentifier: String
    var identifier: String?
    
    init(username: String, text: String, postIdentifier: String, identifier: String? = nil) {
        self.username = username
        self.text = text
        self.postIdentifier = postIdentifier
        self.identifier = identifier
    }
    init?(json: [String : AnyObject], identifier: String) {
        guard let postIdentifier = json[postKey] as? String, let username = json[usernameKey] as? String, let text = json[textKey] as? String else { return nil }
        self.postIdentifier = postIdentifier
        self.username = username
        self.text = text
        self.identifier = identifier
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