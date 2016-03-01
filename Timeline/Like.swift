//
//  Like.swift
//  Timeline
//
//  Created by Cameron Moss on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct Like: Equatable, FirebaseType {
    
    private let postKey = "post"
    private let usernameKey = "username"
    var endpoint: String {
        return "/posts\(self.postIdentifier)/likes/"
    }
    var jsonValue: [String: AnyObject] {
        return [postKey: postIdentifier, usernameKey: username]
    }
    
    var username: String
    var postIdentifier: String
    var identifier: String?
    
    
    
    init(username: String, postIdentifier: String, identifier: String? = nil) {
        self.username = username
        self.postIdentifier = postIdentifier
        self.identifier = nil
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let postIdentifier = json[postKey] as? String, let username = json[usernameKey] as? String else { return nil }
        self.postIdentifier = postIdentifier
        self.username = username
        self.identifier = identifier
    }
}

func ==(lhs: Like, rhs: Like) -> Bool {
    return (lhs.username == rhs.username && lhs.identifier == rhs.identifier)
}
















//Create a Like.swift class file and define a new Like struct
//Add properties for username, postIdentifier, and optional identifier
//Add a memberwise initializer that takes parameters for each property
//Set a default parameter nil for optional properties
//Implement the Equatable protocol by comparing both the usernames and identifiers.