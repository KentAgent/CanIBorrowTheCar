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
    @objc dynamic var model : String = ""
    @objc dynamic var licensePlate : String = ""
    @objc dynamic var owner : String = ""
    @objc dynamic var color : String = ""
    @objc dynamic var isBorrowed : Bool = false
}

class CarRealmManager: RealmManager {
    
    func create(complititon: () -> ()) {
        do {
            try realm.write {
                complititon()
            }
        } catch {
            print("Error saving item \(error)")
        }
    }
    
    func load() -> Results<Car>{
        let car = realm.objects(Car.self)
        return car
    }
    
    func update(complititon: () -> ()) {
        do {
            try realm.write {
                complititon()
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

