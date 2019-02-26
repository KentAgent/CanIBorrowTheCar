//
//  ViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-14.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class CarViewController: UIViewController, UpdateView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageUIImage: UIImageView!
    
    var cars = [CarModel]()
    var users = [UserModel]()
    var sortedCarsByBool: [[CarModel]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        loadCars()
    }

    func loadCars() {
        API.Feed.observeFeed(with: API.User.currentUser!.uid) { (car) in
            guard let carId = car.uid else { return }
            self.fetchUser(uid: carId, completion: {
                self.cars.append(car)
                self.setObjectArraysBasedOnBool()
            })
        }
    }
    
    func updateCarsFromDismiss() {
        self.setObjectArraysBasedOnBool()
    }
    
    func fetchUser(uid: String, completion: (() -> Void)? = nil) {
        API.User.observeUser(uid: uid) { (user) in
            self.users.append(user)
            print(self.users)
            completion!()
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
            vcSelectedCar.selectedCar = sortedCarsByBool![indexPath.section][indexPath.row]
            vcSelectedCar.delegate = self
        }
        if let vcAddCar = segue.destination as? AddCarViewController {
            vcAddCar.delegate = self
        }
    }
    
}
