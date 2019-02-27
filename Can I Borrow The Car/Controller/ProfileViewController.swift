//
//  ProfileViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-26.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: UserModel!
    var cars = [CarModel]()
    var delegate : UpdateView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCurrentUser()
    }
    
    func fetchCurrentUser() {
        API.User.observeCurrentUser { (user) in
            self.user = user
            self.updateNavigationBarUI()
        }
    }
    
    func updateNavigationBarUI() {
        self.navigationItem.title = user.username
    }
    
    @IBAction func addCarButton(_ sender: Any) {
        performSegue(withIdentifier: Segues.goToAddCar, sender: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func signOut(_ sender: Any) {
        AuthServiceSign.signOut(currentVC: self)
    }
    
}
