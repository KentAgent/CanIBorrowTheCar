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
    
    func observeCar(with id: String, completion: @escaping (CarModel) -> (), error: @escaping (Error?) -> ()) {
        carRef.child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let key = snapshot.key
                let newCar = CarModel.transformCarToDict(dict: dict, key: key)
                completion(newCar)
            }
        }) { (er) in
            error(er)
        }
    }

    
    private func observeMyCars(completion: @escaping (CarModel) -> (), error: @escaping (Error?) -> ()) {
        API.User.observeCurrentUser { (user) in
            API.Car.observeCar(with: user.id!, completion: { (car) in
                completion(car)
            }, error: { (er) in
                error(er)
            })
        }
    }
   
    func observeForUpdateMyCar(uploaded: (((DataSnapshot?)) -> Void)? = nil) {
        guard let currentUser = Auth.auth().currentUser else { return }
        refMyCars.child(currentUser.uid).observe(.childAdded) { snapshot in
            uploaded!(snapshot)
        }
    }
    
    func uploadCar(name: String, model: String, licencePlate: String, color: String, borrowed: Bool, uploaded: (() -> Void)? = nil, onError: ((Error?) -> Void)? = nil)  {
        
        guard let currentUser = Auth.auth().currentUser else { return }
        let newAutoCarId = carRef.childByAutoId().key
        let newCarReference = carRef.child(newAutoCarId!)
        let currentUserId = currentUser.uid
        newCarReference.setValue([FIRModelStrings.uid: currentUserId, FIRModelStrings.name : name, FIRModelStrings.model: model, FIRModelStrings.licensePlate: licencePlate, FIRModelStrings.color: color, FIRModelStrings.borrowed: borrowed]) { (error, _) in
            if error != nil {
                onError?(error)
                return
            }
            // Add car to my groups in groupsFeed
            self.addCarToGroups(carId: newAutoCarId!)
            uploaded?()
        }
    }
    
    private func addCarToGroups(carId: String) {
        // Add car to my groups in groupsFeed
        API.Group.observeMyGroups(uploaded: { myGroupsSnapshot in
            if let dict = myGroupsSnapshot?.key {
                API.Group.refGroupFeed.child(dict).child(carId).setValue(true)
            }
        })
        //Add car to My cars
        API.Car.refMyCars.child(API.User.currentUser!.uid).child(carId).setValue(true)
    }
    
    func updateCarValues(with id: String, borrowed: Bool, uploaded: (() -> Void)? = nil, onError: ((String?) -> Void)? = nil)  {
        guard let currentUser = Auth.auth().currentUser else { return }
        let newCarReference = carRef.child(id)
        
        newCarReference.updateChildValues([FIRModelStrings.borrowed: borrowed]) { (error, _) in
            if error != nil {
                onError?(error!.localizedDescription)
                return
            }
            
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
