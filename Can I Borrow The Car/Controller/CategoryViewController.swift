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
    var categoryModel = CategoryModel()
    var categoryRealmManager = CategoryRealmManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryRealmManager.createTheCategories()
        categoryModel.categories = categoryRealmManager.load()
        print(RealmManager.fileURL!)
        tableView.reloadData()
    }
    
    @IBAction func addCarButton(_ sender: Any) {
        performSegue(withIdentifier: Segues.goToAddCar, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let VC = segue.destination as! AddCarViewController
        VC.categoryModel = categoryModel
    }
}

extension CarViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryModel.categories?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.category, for: indexPath)
        cell.textLabel?.text = categoryModel.categories?[indexPath.row].isBorrowed ?? "No Categories added yet"
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}

