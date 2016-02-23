//
//  PostController.swift
//  Timeline
//
//  Created by Cameron Moss on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class PostController {
    
    static func fetchTimelineForUser(user: User, completion: (posts: [Post]) -> Void) {
        completion(posts: mockPosts())
    }
    
    static func addPost(image: String, caption: String?, completion: (success: Bool, post: Post?) -> Void) {
        
    }
    
    static func postFromIdentifier(identifier: String, completion: (post: Post?) -> Void) {
        
    }
    
    static func postsForUser(user: User, completion: (posts: [Post]?) -> Void) {
       completion(posts: mockPosts())
    }
    
    static func deletePost(post: Post) {
        
    }
    
    static func addCommentWithTextToPost(text: String, post: Post, completion: (success: Bool, post: Post?) -> Void) {
        
    }
    
    static func deleteComment(comment: Comment, completion: (success: Bool, post: Post?) -> Void) {
        
    }
    
    static func addLikeToPost(post: Post, completion: (success: Bool, post: Post?) -> Void) {
        
    }
    
    static func deleteLike(like: Like, completion: (success: Bool, post: Post?) -> Void) {
        
    }
    
    static func orderPosts(postsArray: [Post]) -> [Post] {
        return []
    }
    
    static func mockPosts() -> [Post] {
        
        return [
            Post(imageEndPoint: "-K1l4125TYvKMc7rcp5e", caption: nil, username: "", comments: [], likes: [], identifier: nil),
            Post(imageEndPoint: "-K1l4125TYvKMc7rcp5e", caption: nil, username: "", comments: [], likes: [], identifier: nil),
            Post(imageEndPoint: "-K1l4125TYvKMc7rcp5e", caption: nil, username: "", comments: [], likes: [], identifier: nil)
            ]
    }
}
