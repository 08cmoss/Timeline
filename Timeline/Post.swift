//
//  Post.swift
//  Timeline
//
//  Created by Cameron Moss on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct Post: Equatable, FirebaseType {
    private let usernameKey = "username"
    private let imageEndPointKey = "imageEndPoint"
    private let captionKey = "caption"
    private let commentsKey = "comments"
    private let likesKey = "likes"
    var imageEndPoint: String
    var caption: String?
    var username: String
    var comments: [Comment]
    var likes: [Like]
    var identifier: String?
    var endpoint: String {
        return "/posts/"
    }
    var jsonValue: [String: AnyObject] {
        var json: [String: AnyObject] = [usernameKey: username, imageEndPointKey: imageEndPoint, commentsKey: comments.map({$0.jsonValue}), likesKey: likes.map({$0.jsonValue})]
        if let caption = caption {
            json.updateValue(caption, forKey: captionKey)
        }
        return json
    }
    
    
    
    init(imageEndPoint: String, caption: String?, username: String, comments: [Comment], likes: [Like], identifier: String? = nil) {
        
        self.imageEndPoint = imageEndPoint
        self.caption = nil
        self.username = username
        self.comments = []
        self.likes = []
        self.identifier = identifier
        
    }
    init?(json: [String : AnyObject], identifier: String) {
        guard let username = json[usernameKey] as? String, let imageEndPoint = json[imageEndPointKey] as? String, let caption = json[captionKey] as? String else { return nil }
        if let commentDictionaries = json[commentsKey] as? [String: AnyObject] {
            self.comments = commentDictionaries.flatMap({Comment(json: $0.1 as! [String: AnyObject], identifier: $0.0)})
        } else {
            self.comments = []
        }
        
        if let likeDictionaries = json[likesKey] as? [String: AnyObject] {
            self.likes = likeDictionaries.flatMap({Like(json: $0.1 as! [String: AnyObject], identifier: $0.0)})
        } else {
            self.likes = []
        }
        self.username = username
        self.imageEndPoint = imageEndPoint
        self.caption = caption
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