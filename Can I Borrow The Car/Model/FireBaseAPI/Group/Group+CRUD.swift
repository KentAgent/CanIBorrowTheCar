//
//  Group+CRUD.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-06.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit
import Firebase

extension GroupFirebaseModel {
    
    func uploadGroup(name: String, created: (() -> Void)? = nil, onError: (() -> Void)? = nil) {
        if let newAutoGroupId = refGroupFeed.childByAutoId().key {
            let newGroupReference = refGroupFeed.child(newAutoGroupId)
            addCurrentCarsToGroup(groupRef: newGroupReference)
            addGroupToRefs(name: name, groupId: newAutoGroupId)
            created?()
        } else {
            onError?()
        }
    }
    
    private func addCurrentCarsToGroup(groupRef: DatabaseReference) {
        //Add current cars to Family
        API.Car.observeForUpdateMyCar(uploaded: { myCarSnapshot in
            if let dict = myCarSnapshot?.key {
                groupRef.child(dict).setValue(true)
            }
        })
    }
    
    private func addGroupToRefs(name: String, groupId: String) {
        //Add groupId to current user
        API.User.refCurrentUser?.updateChildValues([FIRModelStrings.currentGroupId : groupId, FIRModelStrings.isUserInAGroup : true])
        //Add groupid and name to GroupNames
        API.Group.refGroupName.child(groupId).setValue([FIRModelStrings.groupName: name])
        //Add groupId to MyGroups as current User
        API.Group.refMyGroup.child(API.User.currentUser!.uid).child(groupId).setValue(true)
    }
    
    func observeFeedRemoved(withId id: String, completion: ((CarModel) -> ())? = nil) {
        refGroupFeed.child(id).observe(.childRemoved) { (snapshot) in
            let key = snapshot.key
            API.Car.observeCar(with: key, completion: { (car) in
                completion?(car)
            })
        }
    }
    
    //------------------------------------------------------------------------------------------
    
    func removeCurrentGroup() {
        removeGroupFromRefs { (user) in
            self.removeCurrentCarsFromGroup(user: user)
        }
        
    }
    
    private func removeCurrentCarsFromGroup(user: UserModel) {
        API.Car.observeForUpdateMyCar(uploaded: { myCarSnapshot in
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
    
}
