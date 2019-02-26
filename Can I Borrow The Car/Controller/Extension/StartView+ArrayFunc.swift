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
    
    var sortCarsAtHome : [CarModel] {
        return cars.filter({$0.borrowed == false})
    }
    
    var sortCarsNotAtHome : [CarModel] {
        return cars.filter({$0.borrowed == true})
    }
    
    var sortedCarsByBool : [[CarModel]] {
        return [sortCarsAtHome, sortCarsNotAtHome]
    }
    
    func showLabelOnEmptyTableView() {
        if cars.count == 0 {
            tableView.isHidden = true
            emptyTableViewLabel.isHidden = false
            emptyTableViewLabel.text = "No cars added"
        } else {
            tableView.isHidden = false
            emptyTableViewLabel.isHidden = true
        }
    }
    
}
