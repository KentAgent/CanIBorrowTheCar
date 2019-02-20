//
//  Car.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-14.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import Foundation
import RealmSwift

struct CarModel {
    var cars : Results<Car>?
}

class Car: Object {
    @objc dynamic var carName : String = ""
    @objc dynamic var model : String = ""
    @objc dynamic var licensePlate : String = ""
    @objc dynamic var color : String = ""
    @objc dynamic var borrowed : Bool = false
    let owner = List<User>()
    @objc dynamic var borrowedTo : User?
}

class CarRealmManager: RealmManager {
    
    func create(add: () -> (Car), compilation: (() -> ())? = nil){
        do {
            try realm.write {
                realm.add(add())
                compilation?()
            }
        } catch {
            print("Error saving item \(error)")
        }
    }
    
    func load(loaded: ((Results<Car>) -> ())? = nil){
        let car = realm.objects(Car.self)
        loaded?(car)
    }
    
    func update(update: () -> (Car), compilation: (() -> ())? = nil){
        do {
            try realm.write {
                realm.add(update())
                compilation?()
            }
        } catch {
            print("Error saving item \(error)")
        }
    }
    
    func delete(car: Car) {
        do {
            try realm.write {
                realm.delete(car)
            }
        } catch {
            print("Error saving item \(error)")
        }
    }
}

