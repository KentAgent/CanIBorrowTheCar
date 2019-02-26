//
//  ViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-14.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit
import SDWebImage

class CarViewController: UIViewController, UpdateView {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageUIImage: UIImageView!
    
    var cars = [CarModel]()
    var users = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        updateCurrentUserUI()
        goToProfilePage_TouchUpInside()
        loadCars()
    }

    func loadCars() {
        activityIndicator.startAnimating()
        API.Feed.observeFeed(with: API.User.currentUser!.uid) { (car) in
            guard let carId = car.uid else { return }
            self.fetchUser(uid: carId, completion: {
                self.cars.append(car)
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            })
        }
    }
    
    func fetchUser(uid: String, completion: (() -> ())? = nil) {
        API.User.observeUser(uid: uid) { (user) in
            self.users.append(user)
            print(self.users)
            completion?()
        }
    }
    
    func updateCarsFromDismiss() {
        tableView.reloadData()
    }
    
    func updateCurrentUserUI() {
        profileImageUIImage.isHidden = true
        AppStyle.cirlceUIImageView(image: profileImageUIImage)
        API.User.observeCurrentUser { (user) in
            self.profileImageUIImage.isHidden = false
            SdSetImage.fetchUserImage(image: self.profileImageUIImage, user: user)
        }
    }
    
    func goToProfilePage_TouchUpInside() {
        profileImageUIImage.addTapGestureRecognizer {
            self.performSegue(withIdentifier: Segues.goToProfilePage, sender: nil)
        }
    }
    
    @IBAction func addCarButton(_ sender: Any) {
        performSegue(withIdentifier: Segues.goToAddCar, sender: self)
    }
    
    @IBAction func signOut(_ sender: Any) {
        AuthServiceSign.signOut(currentVC: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let vcSelectedCar = segue.destination as! UpdateChosenCarViewController
            vcSelectedCar.selectedCar = sortedCarsByBool[indexPath.section][indexPath.row]
            vcSelectedCar.delegate = self
        }
        if let vcAddCar = segue.destination as? AddCarViewController {
            vcAddCar.delegate = self
        }
        if let vcProfile = segue.destination as? ProfileViewController {
            
            vcProfile.delegate = self
        }
    }
    
}
