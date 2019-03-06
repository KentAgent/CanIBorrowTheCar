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
    var firstName: String?
    var lastName: String?
    var profileImageUrl: String?
    var currentGroupId: String?
    var isUserInAGroup: Bool?
    //var isFollowing: Bool?
}

extension UserModel {
    static func transformUserToDict(dict: [String: Any], key: String) -> UserModel {
        var user = UserModel()
        user.username = dict[FIRModelStrings.username] as? String
        user.email = dict[FIRModelStrings.email] as? String
        user.profileImageUrl = dict[FIRModelStrings.profileImageUrl] as? String
        user.currentGroupId = dict[FIRModelStrings.currentGroupId] as? String
        user.isUserInAGroup = dict[FIRModelStrings.isUserInAGroup] as? Bool
        user.firstName = dict[FIRModelStrings.firstName] as? String
        user.lastName = dict[FIRModelStrings.lastName] as? String
        user.id = key
        return user
    }
}

