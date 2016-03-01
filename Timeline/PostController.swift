//
//  PostController.swift
//  Timeline
//
//  Created by Cameron Moss on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import UIKit

class PostController {
    
    static func fetchTimelineForUser(user: User, completion: (posts: [Post]) -> Void) {
        UserController.followedByUser(user) { (users) -> Void in
            var postArray: [Post] = []
            let group = dispatch_group_create()
            dispatch_group_enter(group)
            postsForUser(UserController.sharedController.currentUser, completion: { (posts) -> Void in
                    
                if let posts = posts {
                postArray += posts
                }
                dispatch_group_leave(group)
                    
            
            })
            
            if let followed = users {
                for user in followed {
                    dispatch_group_enter(group)
                    postsForUser(user, completion: { (posts) -> Void in
                        if let posts = posts {
                            postArray += posts
                            dispatch_group_leave(group)
                        }
                    })
                }
            }
            dispatch_group_notify(group, dispatch_get_main_queue(), { () -> Void in
                let orderedPosts = orderPosts(postArray)
                completion(posts: orderedPosts)
            })
        }
    }
    
    static func addPost(image: UIImage, caption: String?, completion: (success: Bool, post: Post?) -> Void) {
        ImageController.uploadImage("\(image)") { (identifier) -> Void in
            
            if let identifier = identifier {
                var post = Post(imageEndPoint: identifier, caption: caption, username: UserController.sharedController.currentUser.username)
                post.save()
                completion(success: true, post: post)
            } else {
                completion(success: false, post: nil)
            }
        }
    }
    
    static func postFromIdentifier(identifier: String, completion: (post: Post?) -> Void) {
        
        FirebaseController.dataAtEndPoint("posts/\(identifier)") { (data) -> Void in
            if let data = data as? [String: AnyObject] {
                let post = Post(json: data, identifier: identifier)
            
            completion(post: post)
        } else {
            completion(post: nil)
        }
    }
    }
    
    static func postsForUser(user: User, completion: (posts: [Post]?) -> Void) {
       
        FirebaseController.base.childByAppendingPath("posts").queryOrderedByChild("username").queryEqualToValue(user.username).observeSingleEventOfType(.Value, withBlock: { snapshot in
            if let postDictionaries = snapshot.value as? [String: AnyObject] {
                
                let posts = postDictionaries.flatMap({Post(json: $0.1 as! [String: AnyObject], identifier: $0.0)})
                
                let orderedPosts = orderPosts(posts)
                completion(posts: orderedPosts)
            } else {
                completion(posts: nil)
            }
        })
    }
    
    static func deletePost(post: Post) {
        post.delete()
    }
    
    static func addCommentWithTextToPost(text: String, post: Post, completion: (success: Bool, post: Post?) -> Void) {
        if let postIdentifier = post.identifier {
            
            var comment = Comment(username: UserController.sharedController.currentUser.username, text: text, postIdentifier: postIdentifier)
            comment.save()
            
            PostController.postFromIdentifier(comment.postIdentifier) { (post) -> Void in
                completion(success: true, post: post)
            }
        } else {
            
            var post = post
            post.save()
            var comment = Comment(username: UserController.sharedController.currentUser.username, text: text, postIdentifier: post.identifier!)
            comment.save()
            
            PostController.postFromIdentifier(comment.postIdentifier) { (post) -> Void in
                completion(success: true, post: post)
            }
        }
    }
    
    static func deleteComment(comment: Comment, completion: (success: Bool, post: Post?) -> Void) {
        comment.delete()
        
        PostController.postFromIdentifier(comment.postIdentifier) { (post) -> Void in
            completion(success: true, post: post)
        }
    }
    
    static func addLikeToPost(post: Post, completion: (success: Bool, post: Post?) -> Void) {
        if let postIdentifier = post.identifier {
            var like = Like(username: UserController.sharedController.currentUser.username, postIdentifier: postIdentifier)
            like.save()
        } else {
            var post = post
            post.save()
            var like = Like(username: UserController.sharedController.currentUser.username, postIdentifier: post.identifier!)
            like.save()
        }
        PostController.postFromIdentifier(post.identifier!, completion: { (post) -> Void in
            completion(success: true, post: post)
        })
    }
    
    static func deleteLike(like: Like, completion: (success: Bool, post: Post?) -> Void) {
        like.delete()
        
        PostController.postFromIdentifier(like.postIdentifier) { (post) -> Void in
            completion(success: true, post: post)
        }
    }
    
    static func orderPosts(postsArray: [Post]) -> [Post] {
        return postsArray.sort({$0.0.identifier > $0.1.identifier})
    }
    
    static func mockPosts() -> [Post] {
        
        let post1 = Post(imageEndPoint: "-K1l4125TYvKMc7rcp5e", caption: "So much fun", username: "", comments: [], likes: [], identifier: nil)
        let post2 = Post(imageEndPoint: "-K1l4125TYvKMc7rcp5e", caption: "What a day", username: "", comments: [], likes: [], identifier: nil)
        let post3 = Post(imageEndPoint: "-K1l4125TYvKMc7rcp5e", caption: "This was crazy", username: "", comments: [], likes: [], identifier: nil)
            return [post1, post2, post3]
    }
}
