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
        categoryRealmManager.createTheCategories()
        categoryModel.categories = categoryRealmManager.load()
        carModel.cars = carRealmManager.load()
        print(RealmManager.fileURL!)
        tableView.reloadData()
    }
    
    @IBAction func addCarButton(_ sender: Any) {
        performSegue(withIdentifier: Segues.goToAddCar, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let VC = segue.destination as! AddCarViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            VC.selectedCar = categoryModel.categories![indexPath.section].cars[indexPath.row]
        } else {
            VC.categoryModel = categoryModel
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
}

extension CarViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return categoryModel.categories![0].cars.count
        }
        return categoryModel.categories![1].cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.category, for: indexPath)
        let carName = categoryModel.categories![indexPath.section].cars[indexPath.row].carName
        
        cell.textLabel?.text = "Name: \(carName) Row: \(indexPath.row) Sec: \(indexPath.section)"
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segues.goToAddCar, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryModel.categories!.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = UIColor.lightGray
        if section == 0 {
            label.text = categoryModel.categories?[section].isBorrowed
        } else {
            label.text = categoryModel.categories?[section].isBorrowed
        }
        return label
    }
    
    
}

