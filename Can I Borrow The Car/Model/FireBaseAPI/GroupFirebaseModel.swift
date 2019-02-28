//
//  GroupFirebaseModel.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-28.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit
import Firebase

struct GroupFirebaseModel {
    
    var refGroupFeed = Database.database().reference().child(AuthConfig.groupFeedUrl)
    var refMyGroup = Database.database().reference().child(AuthConfig.myGroupsUrl)
    var refGroupName = Database.database().reference().child(AuthConfig.groupNameUrl)
    
    func uploadGroup(name: String, created: ((CarModel) -> Void)? = nil, onError: ((String?) -> Void)? = nil) {
        guard let newAutoGroupId = refGroupFeed.childByAutoId().key else { return }
        let newGroupReference = refGroupFeed.child(newAutoGroupId)
        API.Car.observeMyCars(uploaded: { myCarSnapshot in
            if let dict = myCarSnapshot?.key {
                newGroupReference.child(dict).setValue(true)
            }
        })
        //Add groupId to current user
        API.User.refCurrentUser?.updateChildValues([FIRModelStrings.currentGroupId : newAutoGroupId])
        //Add groupid and name to GroupNames
        API.Group.refGroupName.child(newAutoGroupId).setValue([FIRModelStrings.groupName: name])
        //Add groupId to MyGroups as current User
        API.Group.refMyGroup.child(API.User.currentUser!.uid).child(newAutoGroupId).setValue(true)
    }
    
    func observeGroupFeed(with groupId: String, completion: ((CarModel) -> ())? = nil) {
        refGroupFeed.child(groupId).observe(.childAdded) { (snapshot) in
            let key = snapshot.key
            API.Car.observeCar(with: key, completion: { (car) in
                completion?(car)
            })
        }
    }
    
    func observeCurrentGroup(completion: @escaping (String) -> ()) {
        API.User.observeCurrentUser { (user) in
            completion(user.currentGroupId!)
        }
    }
    
    func observeMyGroups(uploaded: (((DataSnapshot?)) -> Void)? = nil) {
        guard let currentUser = Auth.auth().currentUser else { return }
        refMyGroup.child(currentUser.uid).observe(.childAdded) { snapshot in
            uploaded!(snapshot)
        }
    }

    func observeMyGroupName(completion: ((GroupModel) -> ())? = nil){
        refMyGroup.child(API.User.currentUser!.uid).observe(.childAdded) { (snapshot) in
            let groupId = snapshot.key
            API.Group.refGroupName.child(groupId).observe(.value, with: { (snapshot) in
                if let dict = snapshot.value as? [String: Any] {
                    let group = GroupModel.transferGroupToDict(dict: dict, key: snapshot.key)
                    completion?(group)
                }
            })
        }
    }

}
