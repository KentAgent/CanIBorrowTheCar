//
//  Borrowed.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-15.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import Foundation
import RealmSwift

struct CategoryModel {
    var categories : Results<Category>?
}

class Category: Object {
    @objc dynamic var isBorrowed : String = ""
    let cars = List<Car>()
}


class CategoryRealmManager: RealmManager {
    
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
        if realm.objects(Category.self).isEmpty {
            create {
                let notBorrowed = Category()
                notBorrowed.isBorrowed = "Not Borrowed"
                let borrowed = Category()
                borrowed.isBorrowed = "Borrowed"
                realm.add(notBorrowed)
                realm.add(borrowed)
            }
        }
    }
    
    func load() -> Results<Category>{
        let categories = realm.objects(Category.self)
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
