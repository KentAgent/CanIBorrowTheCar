//
//  Borrowed.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-15.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import Foundation
import RealmSwift

struct BorrowCarModel {
    var CanIBorrowCar : Results<BorrowCar>?
}

class BorrowCar: Object {
    @objc dynamic var isBorrowed : String = ""
    let cars = List<Car>()
}


class BorrowCarRealmManager: RealmManager {
    
    func create(complititon: () -> ()) {
        do {
            try realm.write {
                complititon()
            }
        } catch {
            print("Error saving category \(error)")
        }
    }
    
    func createTheCategories() {
        if realm.objects(BorrowCar.self).isEmpty {
            create {
                let notBorrowed = BorrowCar()
                notBorrowed.isBorrowed = "Not Borrowed"
                let borrowed = BorrowCar()
                borrowed.isBorrowed = "Borrowed"
                realm.add(notBorrowed)
                realm.add(borrowed)
            }
        }
    }
    
    func load() -> Results<BorrowCar>{
        let categories = realm.objects(BorrowCar.self)
        return categories
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
    
}
