//
//  File.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-28.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

struct GroupModel {
    var id : String?
    var name : String?
}

extension GroupModel {
    static func transferGroupToDict(dict: [String: Any], key: String) -> GroupModel {
        var group = GroupModel()
        group.id = key
        group.name = dict[FIRModelStrings.groupName] as? String
        return group
    }
    
}


