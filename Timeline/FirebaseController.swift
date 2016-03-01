//
//  FirebaseController.swift
//  Timeline
//
//  Created by Cameron Moss on 2/29/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import Firebase

class FirebaseController {
    
    static let base = Firebase(url: "https://timelinefire.firebaseio.com/")
    static func dataAtEndPoint(endpoint: String, completion: (data: AnyObject?) -> Void) {
        let dataRef = base.childByAppendingPath(endpoint)
        dataRef.observeSingleEventOfType(.Value, withBlock: { (snapshot) -> Void in
            if snapshot.value is NSNull {
            completion(data: nil)
            } else {
                completion(data: snapshot)
            }
            
        })
    }
    
    static func observeDataAtEndpoint(endpoint: String, completion: (data: AnyObject?) -> Void) {
        let dataRef2 = base.childByAppendingPath(endpoint)
        dataRef2.observeEventType(.Value, withBlock: { (snapshot) -> Void in
            if snapshot.value is NSNull {
                completion(data: nil)
            } else {
                completion(data: snapshot)
                
            }
        })
    }
}
protocol FirebaseType {
    var identifier: String? { get set }
    var endpoint: String { get }
    var jsonValue: [String: AnyObject] { get }
    
    init?(json: [String: AnyObject], identifier: String)
    
    mutating func save()
    func delete()
}

extension FirebaseType {
    mutating func save () {
        if let identifier = identifier {
            let ref = FirebaseController.base.childByAppendingPath(endpoint)
            ref.setValue(identifier)
            ref.updateChildValues(jsonValue)
        } else {
            FirebaseController.base.childByAutoId()
        }
    }
    
    func delete () {
        FirebaseController.base.removeValue()
    }
}