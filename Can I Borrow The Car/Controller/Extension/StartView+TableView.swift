//
//  CategoryView+TableView.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-20.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import Foundation
import UIKit

extension CarViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let notBorrowed = carModel.cars?.filter({$0.borrowedTo == nil})
//        let borrowed = carModel.cars?.filter({$0.borrowedTo != nil})
        let notBorrowed = carModel.cars?.filter({$0.borrowed == false})
        let borrowed = carModel.cars?.filter({$0.borrowed == true})
        let allCars = [notBorrowed, borrowed]
        return allCars[section]?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.notBorroewd, for: indexPath) as! NotBorrowedCarTableViewCell
//        let notBorrowed = carModel.cars?.filter({$0.borrowedTo == nil})
//        let borrowed = carModel.cars?.filter({$0.borrowedTo != nil})
        let notBorrowed = carModel.cars?.filter({$0.borrowed == false})
        let borrowed = carModel.cars?.filter({$0.borrowed == true})
        
        let allCars = [notBorrowed, borrowed]
        let car = allCars[indexPath.section]?[indexPath.row]
        cell.car = car
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segues.goToChosenCar, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = UIColor.lightGray
        switch section {
        case 0:
            label.text = "Cars at home"
        case 1:
            label.text = "Cars not at home"
        default:
            break
        }
        return label
    }
    

    
    func registerTableView() {
        tableView.register(UINib(nibName: Cell.notBorroewd, bundle: nil), forCellReuseIdentifier: Cell.notBorroewd)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
}

