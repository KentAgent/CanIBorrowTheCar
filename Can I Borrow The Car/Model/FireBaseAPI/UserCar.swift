//
//  UserPostAPI.swift
//  Instagram-FIR
//
//  Created by Kristoffer Knape on 2018-10-25.
//  Copyright © 2018 Kristoffer Knape. All rights reserved.
//

import Foundation
import Firebase

class UserCar {
    var refMyPosts = Database.database().reference().child(AuthConfig.myCarsUrl)

    func loadMyCars(uploaded: (((DataSnapshot)) -> Void)? = nil) {
        guard let currentUser = Auth.auth().currentUser else { return }
        refMyPosts.child(currentUser.uid).observe(.childAdded) { snapshot in
            uploaded!(snapshot)
        }
    }

}
