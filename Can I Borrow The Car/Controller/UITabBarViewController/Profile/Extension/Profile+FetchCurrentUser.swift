//
//  Borrow+FetchCurrentUser.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-05.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

extension ProfileTabBarViewController {
    
    func loadCurrentUser() {
        API.User.observeCurrentUser { (user) in
            self.currentUser = user
            self.userNameLabel.text! = "\(self.currentUser!.firstName!) \(self.currentUser!.lastName!)"
            SdSetImage.fetchUserImage(image: self.profileImageView, user: user)
            AppStyle.cirlceUIImageView(image: self.profileImageView)
            self.tableView.reloadData()
        }
    }
    
    func loadMyCars() {
        API.Car.observeMyCars(completion: { (car) in
            self.myCars.append(car)
            self.tableView.reloadData()
        }) { (er) in
            print(er?.localizedDescription)
        }
    }
    
    private func loadCarsIfInGroup(user: UserModel) {
        if user.currentGroupId != nil {
            self.fetchGroupName()
            API.Group.observeFeed(withId: user.currentGroupId!) { (car) in
                self.myCars.append(car)
            }
        }
    }
    
    private func fetchGroupName() {
        API.Group.observeCurrentGroupName { (group) in
            self.currentGroup = group
            self.navigationItem.title = self.currentGroup?.name
        }
    }
    
}
