//
//  CarModel.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-25.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import Foundation

struct CarModel {
    
    var id : String?
    var name : String?
    var model : String?
    var licensePlate : String?
    var color : String?
    var borrowed : Bool?
    var userId: String?
}

extension CarModel {
    static func transformCarToDict(dict: [String: Any], key: String) -> CarModel {
        var car = CarModel()
        car.id = key
        car.name = dict[FIRModelStrings.name] as? String
        car.model = dict[FIRModelStrings.model] as? String
        car.licensePlate = dict[FIRModelStrings.licensePlate] as? String
        car.color = dict[FIRModelStrings.color] as? String
        car.borrowed = dict[FIRModelStrings.borrowed] as? Bool
        car.userId = dict[FIRModelStrings.uid] as? String
        return car
    }
}
