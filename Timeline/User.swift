//
//  User.swift
//  Timeline
//
//  Created by Cameron Moss on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct User: Equatable, FirebaseType {
    
    private let usernameKey = "username"
    private let bioKey = "bio"
    private let urlKey = "url"
    var endpoint: String {
        return "/users/"
    }
    var jsonValue: [String: AnyObject] {
        return [usernameKey: username, bioKey: bio ?? "", urlKey: url ?? ""]
    }
    var username: String
    var bio: String?
    var url: String?
    var identifier: String?
    
    
    init(username: String, bio: String?, url: String?, identifier: String? = nil) {
        self.username = username
        self.bio = nil
        self.url = nil
        self.identifier = identifier
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let username = json[usernameKey] as? String, let bio = json[bioKey] as? String, let url = json[urlKey] as? String else { return nil }
        self.username = username
        self.bio = bio
        self.url = url
        self.identifier = identifier
    }
}

func ==(lhs: User, rhs: User) -> Bool {
    return (lhs.username == rhs.username && lhs.identifier == rhs.identifier)
}













//Create a User.swift file and define a new User struct.
//Add properties for username, bio, url, and optional identifier.
//note: Since a User can exist without a bio or url, bio and url are optional properties.
//Add a memberwise initializer that takes parameters for each property. The parameter for identifier should be of type String.
//Set a default parameter nil for the bio and url properties.
//Implement the Equatable protocol by comparing both the usernames and identifiers.