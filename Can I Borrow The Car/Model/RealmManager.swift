//
//  RealmManager.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-14.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    let realm = try! Realm()
    let fileURL = Realm.Configuration.defaultConfiguration.fileURL
}
