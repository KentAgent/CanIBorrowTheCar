//
//  ViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-14.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class CarViewController: UIViewController {

    var categoryModel = CategoryModel()
    var carModel = CarModel()
    var categoryRealmManager = CategoryRealmManager()
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
        loadCars()
    }
    
    func loadCars() {
        categoryModel.categories = categoryRealmManager.load()
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
            vcSelectedCar.selectedCar = categoryModel.categories![indexPath.section].cars[indexPath.row]
        } else {
            let vcAddCar = segue.destination as! AddCarViewController
            vcAddCar.categoryModel = categoryModel
        }
    }
    

}
