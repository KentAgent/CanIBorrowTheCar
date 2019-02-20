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
        let allCars = [categoryModel.categories![0].cars, categoryModel.categories![1].cars]
        return allCars[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.notBorroewd, for: indexPath) as! NotBorrowedCarTableViewCell
        let allCars = [self.categoryModel.categories![0].cars, self.categoryModel.categories![1].cars]
        let car = allCars[indexPath.section][indexPath.row]
        cell.car = car
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segues.goToChosenCar, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryModel.categories!.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = UIColor.lightGray
        label.text = categoryModel.categories?[section].isBorrowed
        return label
    }
    
    func registerTableView() {
        tableView.register(UINib(nibName: Cell.notBorroewd, bundle: nil), forCellReuseIdentifier: Cell.notBorroewd)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
}

