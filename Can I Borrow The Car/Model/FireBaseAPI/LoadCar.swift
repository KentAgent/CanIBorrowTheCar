//
//  LoadCar.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-25.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LoadCarModel {
    var refCar = Database.database().reference().child(AuthConfig.carUrl)
    
    func observeCar(completion: @escaping (CarModel) -> ()) {
        refCar.observe(.childAdded) { snapshot in
            if let dict = snapshot.value as? [String: Any] {
                let key = snapshot.key
                let newCar = CarModel.transformCarToDict(dict: dict, key: key)
                completion(newCar)
            }
        }
    }
    
    func observeCar(with id: String, completion: @escaping (CarModel) -> ()) {
        refCar.child(id).observeSingleEvent(of: .value) { snapshot in
            if let dict = snapshot.value as? [String: Any] {
                let key = snapshot.key
                let newCar = CarModel.transformCarToDict(dict: dict, key: key)
                completion(newCar)
            }
        }
    }
    
    
}


