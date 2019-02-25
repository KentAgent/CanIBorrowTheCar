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
    
    var carsAtHome: [CarModel] = []
    var carsNotAtHome: [CarModel] = []
    var allCars: [[CarModel]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        loadCars()
        print("Current User \(API.User.currentUser?.email)")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }
    
    func userUpdateCar() {
        self.tableView.reloadData()
    }
    
    func loadCars() {
        API.Feed.observeFeed(with: API.User.currentUser!.uid) { (car) in
            guard let carId = car.uid else { return }
            self.fetchUser(uid: carId, completion: {
                self.cars.append(car)
                self.setObjectArraysBasedOnBool()
                self.tableView.reloadData()
                print("CAAARS: \(self.cars)")
            })
        }
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let vcSelectedCar = segue.destination as! UpdateChosenCarViewController
            //TODO: FIX indexPath.Section
            //måste ta fram [indexPath.section], annars vet ej cellen jag klickar på, vilken section den ligger i, bara vilken rad.
            vcSelectedCar.selectedCar = allCars?[indexPath.section][indexPath.row]
            vcSelectedCar.delegate = self
        }
    }
    
    @IBAction func signOut(_ sender: Any) {
        AuthServiceSign.signOut(currentVC: self)
    }
    
    
    func setObjectArraysBasedOnBool() {
        carsAtHome.removeAll()
        carsNotAtHome.removeAll()
        allCars?.removeAll()
        for car in cars {
            if car.borrowed == true {
                carsNotAtHome.append(car)
            } else {
                carsAtHome.append(car)
            }
        }
        allCars = [carsAtHome, carsNotAtHome]
    }
    
}
