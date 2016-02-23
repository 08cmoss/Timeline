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
    
    var currentUser: User! = nil
    
    static func userForIdentifier(identifier: String, completion: (user: User?) -> Void) {
        
    }
    
    static func fetchAllUsers(completion: (user: [User]) -> Void) {
        
    }
    
    static func followUser(user: String, completion: (success: Bool) -> Void) {
        
    }
    
    static func unfollowUser(user: String, completion: (success: Bool) -> Void) {
        
    }
    
    static func userFollowsUser(user: String, user2: String, completion: (followsUser: Bool) -> Void) {
        
    }
    
    static func followedByUser(user: String, completion: (users: [User?]) -> Void) {
        
    }
    
    static func authenticateUser(email: String, password: String, completion: (success: Bool, user: User?) -> Void) {
        
    }
    
    
}


//Define a static function createUser that takes an email, username, password, optional bio, optional url, and completion closure with a success Boolean parameter and optional User parameter.
//note: Will be used to create a user in Firebase.
//Define a static function updateUser that takes a user, username, optional bio, optional url, and completion closure with a success Boolean parameter and optional User parameter.
//Define a static function logOutCurrentUser that takes no parameters.
//Define a static function mockUsers() that returns an array of sample users.
//Implement the mockUsers() function by returning an array of at least 3 initialized users
//Use the mockUsers() function to implement staged completion closures in the rest of your static functions with completion closures.
//Update the initialization of the currentUser to the result of the first mock user