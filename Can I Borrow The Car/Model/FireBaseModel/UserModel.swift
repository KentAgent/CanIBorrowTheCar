//
//  User.swift
//  Instagram-FIR
//
//  Created by Kristoffer Knape on 2018-10-21.
//  Copyright © 2018 Kristoffer Knape. All rights reserved.
//

import Foundation

class UserModel {
    var username: String?
    var email: String?
    var profileImageUrl: String?
    var id: String?
    var isFollowing: Bool?
}

extension UserModel {
    static func transformUserToDict(dict: [String: Any], key: String) -> UserModel {
        let user = UserModel()
        
        user.username = dict[FIRStrings.username] as? String
        user.email = dict[FIRStrings.email] as? String
        user.profileImageUrl = dict[FIRStrings.profileImageUrl] as? String
        user.id = key
        return user
    }
}

