//
//  BorrowViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-04.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class BorrowTabBarViewController: UIViewController {
    
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var cars : [CarModel]!
    var group : GroupModel!
    var users : UserModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        loadCarsFromGroup()
    }
    
    private func loadCurrentUser(completion: @escaping (UserModel) -> ()) {
        API.User.observeCurrentUser { (user) in
            self.users = user
            completion(user)
        }
    }
    
    private func loadCarsFromGroup()  {
        //self.activityIndicator.startAnimating()
        loadCurrentUser { user in
            self.navigationItem.title = user.firstName
            if user.currentGroupId != nil {
                self.fetchGroupName()
                API.Group.observeGroupFeed(with: user.currentGroupId!, completion: { (car) in
                    self.cars.append(car)
                    //self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    private func fetchGroupName() {
        API.Group.observeMyGroupName { (group) in
            self.group = group
            self.navigationItem.title = self.group.name
        }
    }
    
}

extension BorrowTabBarViewController: UITableViewDelegate, UITableViewDataSource {
    
    var sortCarsAtHome : [CarModel] {
        return cars.filter({$0.borrowed == false})
    }
    
    var sortCarsNotAtHome : [CarModel] {
        return cars.filter({$0.borrowed == true})
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
