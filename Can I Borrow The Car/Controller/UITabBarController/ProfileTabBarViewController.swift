//
//  ProfileViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-04.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class ProfileTabBarViewController: UIViewController {

    var cars = [CarModel]()
    var group = [GroupModel]()
    var users = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCurrentUser()
    }
    
    private func loadCurrentUser(completion: @escaping (UserModel) -> ()) {
        API.User.observeCurrentUser { (user) in
            self.users.append(user)
            completion(user)
        }
    }
    
    private func setUpCurrentUser() {
        loadCurrentUser { (user) in
            self.navigationItem.title = user.firstName
        }
    }

}
