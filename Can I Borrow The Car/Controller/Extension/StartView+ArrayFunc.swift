//
//  StartView+ArrayFunc.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-26.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import Foundation
import UIKit

extension CarViewController {
    func setObjectArraysBasedOnBool() {
        sortedCarsByBool?.removeAll()
        sortedCarsByBool = [sortCarsAtHome(cars: cars), sortCarsNotAtHome(cars: cars)]
        tableView.reloadData()
    }
    
    func sortCarsAtHome(cars: [CarModel]) -> [CarModel] {
        return cars.filter({$0.borrowed == false})
    }
    
    func sortCarsNotAtHome(cars: [CarModel]) -> [CarModel] {
        return cars.filter({$0.borrowed == true})
    }
    

}
