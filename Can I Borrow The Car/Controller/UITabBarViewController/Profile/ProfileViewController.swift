//
//  ProfileViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-26.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, FetchUser, FetchGroup {

    var cars = [CarModel]()
    var currentGroup : GroupModel?
    var currentUser : UserModel?
    
    var delegate : UpdateView?
    var userDelegate : FetchUser?
    var groupDelegate : FetchGroup?
    
    @IBOutlet weak var groupNameTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if currentUser != nil {
            currentUser = userDelegate?.passCurrentUser()
        }
        if currentGroup != nil {
            currentGroup = groupDelegate?.passCurrentGroup()
        }
        updateNavigationBarUI()
    }
    
    func passCurrentUser() -> UserModel {
        return currentUser!
    }
    
    func passCurrentGroup() -> GroupModel {
        return currentGroup!
    }

    
    @IBAction func observeGroup(_ sender: Any) {
        //API.Group.observeGroups()
    }
    
    @IBAction func removeGroup(_ sender: Any) {
        API.Group.removeCurrentGroup()
    }
    
    @IBAction func createGroupe(_ sender: Any) {
        API.Group.uploadGroup(name: groupNameTextfield.text!)
    }
    
    func updateNavigationBarUI() {
        if currentUser != nil {
            self.navigationItem.title = currentGroup?.name
        }
    }
    
    @IBAction func addCarButton(_ sender: Any) {
        performSegue(withIdentifier: Segues.goToAddCar, sender: nil)
    }
    
    @IBAction func signOut(_ sender: Any) {
        AuthServiceSign.signOut(currentVC: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let profileVC = segue.destination as? ProfileTabBarViewController {
            profileVC.userDelegate = self
            profileVC.groupDelegate = self
        }
    }
    
}
