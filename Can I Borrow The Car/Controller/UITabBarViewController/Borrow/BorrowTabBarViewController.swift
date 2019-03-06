//
//  BorrowViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-04.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class BorrowTabBarViewController: UIViewController, UpdateView  {
    
    func updateCarsFromOnLoad() {
        print("cars updated")
        loadCurrentUser { user in
            //self.loadCarsIfInGroup(user: self.currentUser)
            self.carsInCurrentGroup.removeAll()
            self.loadCarsFromGroup()
        }
    }
    

    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var carsInCurrentGroup = [CarModel]()
    var currentGroup : GroupModel?
    var currentUser : UserModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        noCarsInGroup()
        loadCarsFromGroup()
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let vcSelectedCar = segue.destination as! UpdateChosenCarViewController
            vcSelectedCar.selectedCar = sortedCarsByBool[indexPath.section][indexPath.row]
            vcSelectedCar.delegate = self
        }
    }
    
    func carsInGroup() {
        tableView.isHidden = false
        tableView.dataSource = self
    }
    
    func noCarsInGroup() {
        print("no cars")
        tableView.isHidden = true
        tableView.dataSource = nil
    }
    
}

extension BorrowTabBarViewController: UITableViewDelegate, UITableViewDataSource {
    
    var sortCarsAtHome : [CarModel] {
        return carsInCurrentGroup.filter({$0.borrowed == false})
    }
    
    var sortCarsNotAtHome : [CarModel] {
        return carsInCurrentGroup.filter({$0.borrowed == true})
    }
    
    var sortedCarsByBool : [[CarModel]] {
        return [sortCarsAtHome, sortCarsNotAtHome]
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let allcars = [sortCarsAtHome.count, sortCarsNotAtHome.count]
        return allcars[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.AtHomeCarCell, for: indexPath) as! CarTableViewCell
        let car = sortedCarsByBool[indexPath.section][indexPath.row]
        cell.car = car
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Nibs.carCellHeader) as! HeaderView
        switch section {
        case 0:
            headerView.sectionLabel.text = headerView.atHome
        case 1:
            headerView.sectionLabel.text = headerView.notAtHome
        default:
            break
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segues.goToChosenCar, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func registerTableView() {
        tableView.register(UINib(nibName: Nibs.carCell, bundle: nil), forCellReuseIdentifier: Identifier.AtHomeCarCell)
        let headerNib = UINib.init(nibName: Nibs.carCellHeader, bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: Nibs.carCellHeader)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    
}
