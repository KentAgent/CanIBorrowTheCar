//
//  Borrow+FetchCurrentUser.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-05.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

extension BorrowTabBarViewController {
    
    func loadCurrentUser() {
        if let tabbar = tabBarController as? TabBarController {
            currentUser = tabbar.user
            tableView.reloadData()
        }
    }
    
    func obseveCurrentUser() {
        API.User.observeCurrentUser { (user) in
            self.currentUser = user
            self.fetchGroupName()
            self.navigationItem.title = self.currentUser.firstName ?? self.currentUser.username
            self.tableView.reloadData()
        }
    }
    
    func observeFeed() {
        API.Group.observeFeed(withId: currentUser.currentGroupId!) { (car) in
            guard let carId = car.userId else { return }
            self.fetchUser(uid: carId, completion: {
                self.carsInCurrentGroup.append(car)
                self.tableView.reloadData()
            })
        }

        API.Group.observeFeedRemoved(withId: currentUser.currentGroupId!) { (car) in
            self.carsInCurrentGroup = self.carsInCurrentGroup.filter { $0.id != car.id}
            self.groupUsers = self.groupUsers.filter { $0.id != car.id}
            self.tableView.reloadData()
        }
    }
    
    func fetchUser(uid: String, completion: (() -> Void)? = nil) {
        API.User.observeUser(uid: uid) { (user) in
            self.groupUsers.append(user)
            completion!()
        }
    }
    
    private func fetchGroupName() {
        API.Group.observeCurrentGroupName { group in
            self.currentGroup = group
            let name = self.currentGroup?.name ?? "No group added"
            self.navigationItem.title = "Group: \(name)"
        }
    }
    
}
