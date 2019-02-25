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
        let carsAtHome = cars.filter({$0.borrowed == false})
        let carsNotAtHome = cars.filter({$0.borrowed == true})

        let allcars = [carsAtHome.count, carsNotAtHome.count]
        
        return allcars[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.notBorroewd, for: indexPath) as! CarTableViewCell
        //TODO: FIX indexPath.Section
        //måste ta fram [indexPath.section], annars blir alla med samma indexpath.row likadana, oberoende section
        let car = cars[indexPath.row]
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segues.goToChosenCar, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func registerTableView() {
        tableView.register(UINib(nibName: Cell.notBorroewd, bundle: nil), forCellReuseIdentifier: Cell.notBorroewd)
        let headerNib = UINib.init(nibName: Nibs.carCellHeader, bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: Nibs.carCellHeader)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
}

