//
//  Borrow+FetchCurrentUser.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-05.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

extension BorrowTabBarViewController {
    
    func loadCarsFromGroup()  {
        loadCurrentUser { user in
            //self.loadCarsIfInGroup(user: self.currentUser)
            self.loadCar()
        }
    }
    
    func loadCurrentUser(completion: @escaping (UserModel) -> ()) {
        API.User.observeCurrentUser { user in
            self.currentUser = user
            completion(user)
        }
    }
    
    private func loadCar() {
        if let id = currentUser.currentGroupId {
            fetchGroupName()
            API.Group.observeGroupFeed(with: id, completion: { car in
                self.carsInGroup()
                self.carsInCurrentGroup.append(car)
                self.tableView.reloadData()
            }) { (error) in
                self.noCarsInGroup()
                print(error?.localizedDescription as Any)
            }
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
