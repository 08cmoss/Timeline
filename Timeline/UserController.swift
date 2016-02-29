//
//  UserController.swift
//  Timeline
//
//  Created by Cameron Moss on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class UserController {
    
    static let sharedController = UserController()
    
    var currentUser: User! = User(username: "Cameron", bio: nil, url: nil, identifier: nil)
    
    static func userForIdentifier(identifier: String, completion: (user: User?) -> Void) {
        
    }
    
    static func fetchAllUsers(completion: (user: [User]) -> Void) {
        completion(user: mockUsers())
    }
    
    static func followUser(user: User, completion: (success: Bool) -> Void) {
        completion(success: true)
    }
    
    static func unfollowUser(user: User, completion: (success: Bool) -> Void) {
        completion(success: true)
    }
    
    static func userFollowsUser(user: User, user2: User, completion: (followsUser: Bool) -> Void) {
        completion(followsUser: true)
    }
    
    static func followedByUser(user: User, completion: (users: [User]?) -> Void) {
        completion(users: mockUsers())
    }
    
    static func authenticateUser(email: String, password: String, completion: (success: Bool, user: User?) -> Void) {
        completion(success: true, user: mockUsers().last)
    }
    
    static func createUser(email: String, username: String, password: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        completion(success: true, user: mockUsers().last)
    }
    
    static func updateUser(user: User, username: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        completion(success: true, user: mockUsers().last)
    }
    
    static func logOutCurrentUser() {
        
        sharedController.currentUser = nil
        
    }
    
    static func mockUsers() -> [User] {
        
        
        let user1 = User(username: "Cameron", bio: "junior iOS developer", url: nil, identifier: nil)
        let user2 = User(username: "Jake", bio: "Savant", url: nil, identifier: nil)
        let user3 = User(username: "Michael", bio: "iOS developer", url: nil, identifier: nil)
        return [user1, user2, user3]
        
    }
    
    
}
