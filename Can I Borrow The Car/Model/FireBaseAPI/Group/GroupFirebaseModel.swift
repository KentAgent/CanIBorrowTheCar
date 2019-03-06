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
    
    func observeFeed(withId id: String, completion: ((CarModel) -> ())? = nil) {
        refGroupFeed.child(id).observe(.childAdded) { (snapshot) in
            let key = snapshot.key
            API.Car.observeCar(with: key, completion: { (car) in
                completion!(car)
            })
        }
    }
    

    
    func observeGroupCarFeedChanges(with groupId: String, completion: @escaping (CarModel) -> Void, error: ((Error?) -> ())? = nil ) {
        refGroupFeed.child(groupId).observe(.childChanged, with: { (snapshot) in
            let cars = snapshot.key
            API.Car.observeCar(with: cars, completion: { (car) in
                completion(car)
            }, error: { (er) in
                error?(er)
            })
        }) { (er) in
            error?(er)
        }
    }

    func observeMyGroups(uploaded: (((DataSnapshot?)) -> Void)? = nil) {
        guard let currentUser = Auth.auth().currentUser else { return }
        refMyGroup.child(currentUser.uid).observe(.childAdded) { snapshot in
            uploaded!(snapshot)
        }
    }

    func observeCurrentGroupName(completion: @escaping (GroupModel) -> ()){
        refMyGroup.child(API.User.currentUser!.uid).observe(.childAdded) { (snapshot) in
            let groupId = snapshot.key
            self.observeGroupName(with: groupId, completion: { (group) in
                completion(group)
            })
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
