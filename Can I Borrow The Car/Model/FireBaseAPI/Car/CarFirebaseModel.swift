//
//  Car.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-26.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import Foundation
import Firebase
import UIKit

struct CarFirebaseModel {
    var carRef = Database.database().reference().child(AuthConfig.carUrl)
    var refMyCars = Database.database().reference().child(AuthConfig.myCarsUrl)
    
    func observeCar(with id: String, completion: @escaping (CarModel) -> (), error: ((Error?) -> ())? = nil) {
        carRef.child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let key = snapshot.key
                let newCar = CarModel.transformCarToDict(dict: dict, key: key)
                completion(newCar)
            }
        }) { (er) in
            error?(er)
        }
    }
    
    func observeMyCars(completion: @escaping (CarModel) -> (), error: @escaping (Error?) -> ()) {
        observeMyCarAdded { (snapshot) in
            API.Car.observeCar(with: snapshot.key, completion: { (car) in
                completion(car)
            }, error: { (er) in
                error(er)
            })
        }
    }

    private func observeMyCarAdded(uploaded: @escaping (DataSnapshot) -> Void) {
        guard let currentUser = Auth.auth().currentUser else { return }
        refMyCars.child(currentUser.uid).observe(.childAdded) { snapshot in
            uploaded(snapshot)
        }
    }
   
    func observeForUpdateMyCar(uploaded: (((DataSnapshot?)) -> Void)? = nil) {
        guard let currentUser = Auth.auth().currentUser else { return }
        refMyCars.child(currentUser.uid).observe(.childAdded) { snapshot in
            uploaded!(snapshot)
        }
    }
    
}
