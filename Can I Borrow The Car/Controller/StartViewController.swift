//
//  ViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-14.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class CarViewController: UIViewController, UpdateView {
 
    var carModel = CarModel()
    var carRealmManager = CarRealmManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        loadCars()
        print(RealmManager.fileURL!)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }
    
    func userUpdateCar() {
        self.tableView.reloadData()
    }
    
    func loadCars() {
        carRealmManager.load { (car) in
            self.carModel.cars = car
            self.tableView.reloadData()
        }
    }
    
    @IBAction func addCarButton(_ sender: Any) {
        performSegue(withIdentifier: Segues.goToAddCar, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let vcSelectedCar = segue.destination as! UpdateChosenCarViewController
            vcSelectedCar.selectedCar = carModel.cars![indexPath.row]
            vcSelectedCar.delegate = self
        }
    }
    

}
