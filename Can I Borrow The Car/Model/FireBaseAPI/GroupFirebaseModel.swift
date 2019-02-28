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
    
    var refGroup = Database.database().reference().child(AuthConfig.groupFeedUrl)
    var refMyGroup = Database.database().reference().child(AuthConfig.myGroupsUrl)
    var refGroupName = Database.database().reference().child(AuthConfig.groupNameUrl)
    
    func uploadGroup(name: String, created: (() -> Void)? = nil, onError: ((String?) -> Void)? = nil) {
        //guard let currentUser = Auth.auth().currentUser else { return }
        //let currentUserId = currentUser.uid
        guard let newAutoGroupId = refGroup.childByAutoId().key else { return }
        let newGroupReference = refGroup.child(newAutoGroupId)
        
        newGroupReference.setValue([API.User.currentUser!.uid: true]) { (error, _) in
            if error != nil {
                onError?(error!.localizedDescription)
                return
            }
            API.Group.refMyGroup.child(API.User.currentUser!.uid).child(newAutoGroupId).setValue(true)
            API.Group.refGroupName.child(newAutoGroupId).setValue([FIRModelStrings.groupName: name])
        }
    }
    
    func observeGroups(observe: ((String) -> Void)? = nil){
        refMyGroup.child(API.User.currentUser!.uid).observe(.childAdded) { (snapshot) in
            let myGroupId = snapshot.key
            API.Group.refGroup.child(myGroupId).observe(.childAdded, with: { (snapshot) in
                let userId = snapshot.key
                observe?(userId)
            })
        }
    }
    
    func observeGroupName(name: ((String) -> ())? = nil){
        refMyGroup.child(API.User.currentUser!.uid).observe(.childAdded) { (snapshot) in
            let groupId = snapshot.key
            API.Group.refGroupName.child(groupId).observe(.childAdded, with: { (snapshot) in
                name!(String(describing: snapshot.value!))
            })
        }
    }
    
}
