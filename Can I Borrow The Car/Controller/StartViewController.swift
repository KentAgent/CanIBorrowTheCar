//
//  ViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-14.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class CarViewController: UIViewController, UpdateView {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageUIImage: UIImageView!
    @IBOutlet weak var emptyTableViewLabel: UILabel!
    
    var cars = [CarModel]()
    var users = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        loadCars()
    }

    func loadCars() {
        self.showLabelOnEmptyTableView()
        activityIndicator.startAnimating()
        API.Feed.observeFeed(with: API.User.currentUser!.uid) { (car) in
            guard let carId = car.uid else { return }
            self.fetchUser(uid: carId, completion: {
                self.cars.append(car)
                self.showLabelOnEmptyTableView()
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            })
        }
    }
    
    func updateCarsFromDismiss() {
        tableView.reloadData()
    }
    
    func fetchUser(uid: String, completion: (() -> ())? = nil) {
        API.User.observeUser(uid: uid) { (user) in
            self.users.append(user)
            print(self.users)
            completion?()
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
    }
    
}
