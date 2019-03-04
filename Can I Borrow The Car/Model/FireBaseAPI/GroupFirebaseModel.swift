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
        addCurrentCarsToGroup(groupRef: newGroupReference)
        addGroupToRefs(name: name, groupId: newAutoGroupId)
    }
    
    func removeCurrentGroup() {
        removeGroupFromRefs { (user) in
            self.removeCurrentCarsFromGroup(user: user)
        }
        
    }
    
    func observeGroupFeed(with groupId: String, completion: ((CarModel) -> ())? = nil) {
        refGroupFeed.child(groupId).observe(.childAdded) { (snapshot) in
            let key = snapshot.key
            API.Car.observeCar(with: key, completion: { (car) in
                completion?(car)
            })
        }
    }

    func observeMyGroups(uploaded: (((DataSnapshot?)) -> Void)? = nil) {
        guard let currentUser = Auth.auth().currentUser else { return }
        refMyGroup.child(currentUser.uid).observe(.childAdded) { snapshot in
            uploaded!(snapshot)
        }
    }

    func observeMyGroupName(completion: @escaping (GroupModel) -> ()){
        refMyGroup.child(API.User.currentUser!.uid).observe(.childAdded) { (snapshot) in
            let groupId = snapshot.key
            self.observeGroupName(with: groupId, completion: { (group) in
                completion(group)
            })
        }
    }
    
    private func addCurrentCarsToGroup(groupRef: DatabaseReference) {
        //Add current cars to Family
        API.Car.observeMyCars(uploaded: { myCarSnapshot in
            if let dict = myCarSnapshot?.key {
                groupRef.child(dict).setValue(true)
            }
        })
    }
    
    private func addGroupToRefs(name: String, groupId: String) {
        //Add groupId to current user
        API.User.refCurrentUser?.updateChildValues([FIRModelStrings.currentGroupId : groupId])
        //Add groupid and name to GroupNames
        API.Group.refGroupName.child(groupId).setValue([FIRModelStrings.groupName: name])
        //Add groupId to MyGroups as current User
        API.Group.refMyGroup.child(API.User.currentUser!.uid).child(groupId).setValue(true)
    }
    
    private func removeCurrentCarsFromGroup(user: UserModel) {
        API.Car.observeMyCars(uploaded: { myCarSnapshot in
            if let dict = myCarSnapshot?.key {
                self.refGroupFeed.child(user.currentGroupId!).child(dict).setValue(NSNull())
                //remove groupId from current user
                API.User.refCurrentUser?.child(FIRModelStrings.currentGroupId).setValue(NSNull())
            }
        })
    }
    
    private func removeGroupFromRefs(completion: @escaping (UserModel) -> ()) {
        API.User.observeCurrentUser { user in
            //remove groupid and name from GroupNames
            API.Group.refGroupName.child(user.currentGroupId!).child(FIRModelStrings.groupName).removeValue()
            //remove groupId from MyGroups as current User
            API.Group.refMyGroup.child(API.User.currentUser!.uid).child(user.currentGroupId!).setValue(NSNull())
            completion(user)
        }
        
    }
    
    private func observeGroupName(with groupId: String, completion: @escaping (GroupModel) -> ()) {
        API.Group.refGroupName.child(groupId).observe(.value, with: { (snapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let group = GroupModel.transferGroupToDict(dict: dict, key: snapshot.key)
                completion(group)
            }
        })
    }
    

}
