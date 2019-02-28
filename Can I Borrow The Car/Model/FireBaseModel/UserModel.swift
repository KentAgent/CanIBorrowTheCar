//
//  User.swift
//  Instagram-FIR
//
//  Created by Kristoffer Knape on 2018-10-21.
//  Copyright © 2018 Kristoffer Knape. All rights reserved.
//

import Foundation

struct UserModel {
    var id: String?
    var username: String?
    var email: String?
    var profileImageUrl: String?
    //var isFollowing: Bool?
}

extension UserModel {
    static func transformUserToDict(dict: [String: Any], key: String) -> UserModel {
        var user = UserModel()
        user.username = dict[FIRModelStrings.username] as? String
        user.email = dict[FIRModelStrings.email] as? String
        user.profileImageUrl = dict[FIRModelStrings.profileImageUrl] as? String
        user.id = key
        return user
    }
}

