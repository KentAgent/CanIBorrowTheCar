//
//  Borrowed.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-15.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import Foundation
import RealmSwift

struct UserModel {
    var categories : Results<User>?
}

class User: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var age : Int = 0
    @objc dynamic var sex : String = ""
}


class UserRealmManager: RealmManager {
    
    func create(complititon: () -> ()) {
        do {
            try realm.write {
                complititon()
            }
        } catch {
            print("Error saving User \(error)")
        }
    }
    
    func load() -> Results<User>{
        let categories = realm.objects(User.self)
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
