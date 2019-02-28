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
//fromURL: AuthConfig.FIRUrl
    var carRef = Database.database().reference().child(AuthConfig.carUrl)
    var refMyCars = Database.database().reference().child(AuthConfig.myCarsUrl)
    
    func observeCar(completion: @escaping (CarModel) -> ()) {
        carRef.observe(.childAdded) { snapshot in
            if let dict = snapshot.value as? [String: Any] {
                let key = snapshot.key
                let newCar = CarModel.transformCarToDict(dict: dict, key: key)
                completion(newCar)
            }
        }
    }
    
    func observeCar(with id: String, completion: @escaping (CarModel) -> ()) {
        carRef.child(id).observeSingleEvent(of: .value) { snapshot in
            if let dict = snapshot.value as? [String: Any] {
                let key = snapshot.key
                let newCar = CarModel.transformCarToDict(dict: dict, key: key)
                completion(newCar)
            }
        }
    }
    
    func observeMyCars(uploaded: (((DataSnapshot)) -> Void)? = nil) {
        guard let currentUser = Auth.auth().currentUser else { return }
        refMyCars.child(currentUser.uid).observe(.childAdded) { snapshot in
            uploaded!(snapshot)
        }
    }
    
    func uploadCar(name: String, model: String, licencePlate: String, color: String, borrowed: Bool, uploaded: (() -> Void)? = nil, onError: ((String?) -> Void)? = nil)  {
        
        guard let currentUser = Auth.auth().currentUser else { return }
        let newAutoCarId = carRef.childByAutoId().key
        let newCarReference = carRef.child(newAutoCarId!)
        let currentUserId = currentUser.uid
        
        newCarReference.setValue([FIRModelStrings.uid: currentUserId, FIRModelStrings.name : name, FIRModelStrings.model: model, FIRModelStrings.licensePlate: licencePlate, FIRModelStrings.color: color, FIRModelStrings.borrowed: borrowed]) { (error, _) in
            if error != nil {
                onError?(error!.localizedDescription)
                return
            }
            
            API.Feed.refFeed.child(API.User.currentUser!.uid).child(newAutoCarId!).setValue(true)
            API.Car.refMyCars.child(currentUser.uid).child(newAutoCarId!).setValue(true)
            
            uploaded?()
        }
    }
    
    func updateCarValues(with id: String, borrowed: Bool, uploaded: (() -> Void)? = nil, onError: ((String?) -> Void)? = nil)  {
        guard let currentUser = Auth.auth().currentUser else { return }
        let newCarReference = carRef.child(id)
        
        newCarReference.updateChildValues([FIRModelStrings.borrowed: borrowed]) { (error, _) in
            if error != nil {
                onError?(error!.localizedDescription)
                return
            }
            
            API.Feed.refFeed.child(API.User.currentUser!.uid).child(id).setValue(true)
            
            let myCarRef = API.Car.refMyCars.child(currentUser.uid).child(id)
            myCarRef.setValue(true, withCompletionBlock: { (error, _) in
                if error != nil {
                    onError!(error!.localizedDescription)
                    return
                }
            })
            uploaded?()
        }
    }
    
}
