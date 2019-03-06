//
//  Borrow+FetchCurrentUser.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-05.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

extension ProfileTabBarViewController {

    func loadCarsFromGroup()  {
        loadCurrentUser { (user) in
            self.loadCarsIfInGroup(user: self.currentUser!)
        }
    }
    
    private func loadCurrentUser(completion: @escaping (UserModel) -> ()) {
        API.User.observeCurrentUser { (user) in
            self.currentUser = user
            self.navigationItem.title = self.currentUser?.firstName
            completion(user)
        }
    }
    
    private func loadCarsIfInGroup(user: UserModel) {
        if user.currentGroupId != nil {
            self.fetchGroupName()
            API.Group.observeGroupFeed(with: user.currentGroupId!, completion: { (car) in
                self.cars.append(car)
                //self.activityIndicator.stopAnimating()
            })
        }
    }
    
    private func fetchGroupName() {
        API.Group.observeCurrentGroupName { (group) in
            self.currentGroup = group
            self.navigationItem.title = self.currentGroup?.name
        }
    }
    
}
