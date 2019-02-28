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
    @IBOutlet weak var groupName: UILabel!
    
    var cars = [CarModel]()
    var group : GroupModel!
    var users = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidload")
        registerTableView()
        updateCurrentUserUI()
        goToProfilePage_TouchUpInside()
        loadCarsFromGroup()
        fetchGroupName()
    }
    
    private func loadCurrentUser(completion: @escaping (UserModel) -> ()) {
        API.User.observeCurrentUser { (user) in
            self.users.append(user)
            completion(user)
        }
    }
    
    private func loadCarsFromGroup()  {
        self.activityIndicator.startAnimating()
        loadCurrentUser { user in
            API.Group.observeGroupFeed(with: user.currentGroupId!, completion: { (car) in
                self.cars.append(car)
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            })
        }
    }
    
    private func fetchGroupName() {
        API.Group.observeMyGroupName { (group) in
            self.group = group
            self.groupName.text = self.group.name
        }
    }
    
    func updateCarsFromDismiss() {
        tableView.reloadData()
    }
    
    private func updateCurrentUserUI() {
        profileImageUIImage.isHidden = true
        AppStyle.cirlceUIImageView(image: profileImageUIImage)
        API.User.observeCurrentUser { (user) in
            self.profileImageUIImage.isHidden = false
            SdSetImage.fetchUserImage(image: self.profileImageUIImage, user: user)
        }
    }
    
    private func goToProfilePage_TouchUpInside() {
        profileImageUIImage.addTapGestureRecognizer {
            self.performSegue(withIdentifier: Segues.goToProfilePage, sender: nil)
        }
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
    
    //    func loadCars() {
    //        activityIndicator.startAnimating()
    //        API.Feed.observeFeed(with: "", completion: <#T##((CarModel) -> ())?##((CarModel) -> ())?##(CarModel) -> ()#>)
    //        API.Feed.observeFeed(with: API.User.currentUser!.uid) { (car) in
    //            guard let carId = car.userId else { return }
    //            self.fetchUser(uid: carId, completion: {
    //                self.cars.append(car)
    //                self.activityIndicator.stopAnimating()
    //                self.tableView.reloadData()
    //            })
    //        }
    //    }
    //
    //    func fetchUser(uid: String, completion: (() -> ())? = nil) {
    //        API.User.observeUser(uid: uid) { (user) in
    //            self.users.append(user)
    //            completion?()
    //        }
    //    }
    
}
