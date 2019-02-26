//
//  CarModel.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-25.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import Foundation

class CarModel {
    
    var id : String?
    var name : String?
    var model : String?
    var licensePlate : String?
    var color : String?
    var borrowed : Bool?
    var uid: String?
}

extension CarModel {
    static func transformCarToDict(dict: [String: Any], key: String) -> CarModel {
        let car = CarModel()
        car.id = key
        car.name = dict[FIRStrings.name] as? String
        car.model = dict[FIRStrings.model] as? String
        car.licensePlate = dict[FIRStrings.licensePlate] as? String
        car.color = dict[FIRStrings.color] as? String
        car.borrowed = dict[FIRStrings.borrowed] as? Bool
        car.uid = dict[FIRStrings.uid] as? String
        return car
    }
}
