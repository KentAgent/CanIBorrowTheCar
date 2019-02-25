//
//  UploadCar.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-25.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class UploadCarModel {
    
    var carRef = Database.database().reference(fromURL: AuthConfig.FIRUrl).child(AuthConfig.carUrl)
    
    func uploadCar(name: String, model: String, licencePlate: String, color: String, borrowed: Bool, uploaded: (() -> Void)? = nil, onError: ((String?) -> Void)? = nil)  {
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
            
            let myCarRef = API.MyCar.refMyPosts.child(currentUser.uid).child(newCarId!)
            myCarRef.setValue(true, withCompletionBlock: { (error, _) in
                if error != nil {
                    onError!(error!.localizedDescription)
                    return
                }
            })
            uploaded?()
        }
    }
    
    func updateCar(with id: String, borrowed: Bool, uploaded: (() -> Void)? = nil, onError: ((String?) -> Void)? = nil)  {
        guard let currentUser = Auth.auth().currentUser else { return }
        let newCarReference = carRef.child(id)
        
        newCarReference.updateChildValues([FIRStrings.borrowed: borrowed]) { (error, _) in
            if error != nil {
                onError?(error!.localizedDescription)
                return
            }
            
            API.Feed.refFeed.child(API.User.currentUser!.uid).child(id).setValue(true)
            
            let myCarRef = API.MyCar.refMyPosts.child(currentUser.uid).child(id)
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
