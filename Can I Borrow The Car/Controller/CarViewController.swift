//
//  ViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-14.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class CarViewController: UIViewController {

    //weak var coordinator: MainCoordinator?
    var carModel = CarModel()
    var borrowCarModel = BorrowCarModel()
    var borrowCarRealmManager = BorrowCarRealmManager()
    var carRealmManager = CarRealmManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(carRealmManager.fileURL!)
        borrowCarRealmManager.createTheCategories()
    }
}

extension CarViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carModel.cars?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.carCell, for: indexPath)
        
        if let car = carModel.cars?[indexPath.row] {
            cell.textLabel?.text = car.carName
            cell.accessoryType = car.isBorrowed ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No cars added yet"
        }
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let car = carModel.cars?[indexPath.row] {
            carRealmManager.update {
                car.isBorrowed.toggle()
            }
        }
        self.tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}

