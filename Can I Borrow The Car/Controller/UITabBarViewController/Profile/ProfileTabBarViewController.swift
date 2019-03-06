//
//  ProfileViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-04.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

protocol FetchUser {
    func passCurrentUser() -> UserModel
}

protocol FetchGroup {
    func passCurrentGroup() -> GroupModel
}

class ProfileTabBarViewController: UIViewController, FetchUser, FetchGroup {

    var cars = [CarModel]()
    var currentGroup : GroupModel?
    var currentUser : UserModel?
    
    var userDelegate : FetchUser?
    var groupDelegate : FetchGroup?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCarsFromGroup()
        if currentUser != nil {
            currentUser = userDelegate?.passCurrentUser()
        }
        if currentGroup != nil {
            currentGroup = groupDelegate?.passCurrentGroup()
        }
    }
    
    func passCurrentUser() -> UserModel {
        return self.currentUser!
    }
    
    func passCurrentGroup() -> GroupModel {
        return self.currentGroup!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vcAddGroup = segue.destination as? ProfileViewController {
            vcAddGroup.userDelegate = self
            vcAddGroup.groupDelegate = self
            vcAddGroup.hidesBottomBarWhenPushed = true
        }
    }
}
