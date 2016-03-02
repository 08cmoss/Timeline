//
//  UserController.swift
//  Timeline
//
//  Created by Cameron Moss on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class UserController {
    
    private let kUser = "userKey"
    
    static let sharedController = UserController()
    
    var currentUser: User! {
        get {
            
            guard let uid = FirebaseController.base.authData.uid,
                let userDictionary = NSUserDefaults.standardUserDefaults().valueForKey(kUser) as? [String: AnyObject] else {
                    
                    return nil
            }
            
            return User(json: userDictionary, identifier: uid)
        }
        
        set {
            if let newValue = newValue {
                NSUserDefaults.standardUserDefaults().setValue(newValue.jsonValue, forKey: kUser)
                NSUserDefaults.standardUserDefaults().synchronize()
            } else {
                NSUserDefaults.standardUserDefaults().removeObjectForKey(kUser)
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
    }
    
    static func userForIdentifier(identifier: String, completion: (user: User?) -> Void) {
        FirebaseController.dataAtEndPoint("users/\(identifier)") { (data) -> Void in
            if let data = data as? [String: AnyObject] {
                let user = User(json: data, identifier: identifier)
                completion(user: user)
            } else {
                completion(user: nil)
            }
        }
    }
    
    static func fetchAllUsers(completion: (user: [User]) -> Void) {
        FirebaseController.dataAtEndPoint("users") { (data) -> Void in
            if let data = data as? [String: AnyObject] {
                let user = data.flatMap({ (User(json: $0.0, identifier: $0.1)) -> SequenceType in
                    <#code#>
                })
            }
        }
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
