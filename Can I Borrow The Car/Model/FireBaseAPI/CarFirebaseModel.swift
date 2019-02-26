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

class CarFirebaseModel {

    var refCarURL = Database.database().reference().child(AuthConfig.carUrl)
    var carRef = Database.database().reference(fromURL: AuthConfig.FIRUrl).child(AuthConfig.carUrl)
    var refMyCars = Database.database().reference().child(AuthConfig.myCarsUrl)

    
    func observeCar(completion: @escaping (CarModel) -> ()) {
        refCarURL.observe(.childAdded) { snapshot in
            if let dict = snapshot.value as? [String: Any] {
                let key = snapshot.key
                let newCar = CarModel.transformCarToDict(dict: dict, key: key)
                completion(newCar)
            }
        }
    }
    
    func observeCar(with id: String, completion: @escaping (CarModel) -> ()) {
        refCarURL.child(id).observeSingleEvent(of: .value) { snapshot in
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
    
    func uploadCarValues(name: String, model: String, licencePlate: String, color: String, borrowed: Bool, uploaded: (() -> Void)? = nil, onError: ((String?) -> Void)? = nil)  {
        guard let currentUser = Auth.auth().currentUser else { return }
        let newCarId = carRef.childByAutoId().key
        let newCarReference = carRef.child(newCarId!)
        let currentUserId = currentUser.uid
        
        newCarReference.setValue([FIRStrings.uid: currentUserId, FIRStrings.name : name, FIRStrings.model: model, FIRStrings.licensePlate: licencePlate, FIRStrings.color: color, FIRStrings.borrowed: borrowed]) { (error, _) in
            if error != nil {
                onError?(error!.localizedDescription)
                return
            }
            
            API.Feed.refFeed.child(API.User.currentUser!.uid).child(newCarId!).setValue(true)
            
            let myCarRef = API.Car.refMyCars.child(currentUser.uid).child(newCarId!)
            myCarRef.setValue(true, withCompletionBlock: { (error, _) in
                if error != nil {
                    onError!(error!.localizedDescription)
                    return
                }
            })
            uploaded?()
        }
    }
    
    func updateCarValues(with id: String, borrowed: Bool, uploaded: (() -> Void)? = nil, onError: ((String?) -> Void)? = nil)  {
        guard let currentUser = Auth.auth().currentUser else { return }
        let newCarReference = carRef.child(id)
        
        newCarReference.updateChildValues([FIRStrings.borrowed: borrowed]) { (error, _) in
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
