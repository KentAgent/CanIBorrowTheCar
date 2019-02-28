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
        //guard let currentUser = Auth.auth().currentUser else { return }
        //let currentUserId = currentUser.uid
        guard let newAutoGroupId = refGroupFeed.childByAutoId().key else { return }
        let newGroupReference = refGroupFeed.child(newAutoGroupId)
        API.Car.observeMyCars(uploaded: { myCarSnapshot in
            if let dict = myCarSnapshot?.key {
                newGroupReference.child(dict).setValue(true)
            }
        })
        API.User.refCurrentUser?.updateChildValues([FIRModelStrings.currentGroupId : newAutoGroupId])
        API.Group.refGroupName.child(newAutoGroupId).setValue([FIRModelStrings.groupName: name])
        API.Group.refMyGroup.child(API.User.currentUser!.uid).child(newAutoGroupId).setValue(true)
    }
    
    func observeCurrentGroup() {
        
    }
    
    func observeGroupName(completion: ((GroupModel) -> ())? = nil){
        refMyGroup.child(API.User.currentUser!.uid).observe(.childAdded) { (snapshot) in
            let groupId = snapshot.key
            API.Group.refGroupName.child(groupId).observe(.value, with: { (snapshot) in
                if let dict = snapshot.value as? [String: Any] {
                    let groupName = GroupModel.transferGroupToDict(dict: dict, key: snapshot.key)
                    completion?(groupName)
                }
            })
        }
    }
    
}
