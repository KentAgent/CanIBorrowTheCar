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

}
