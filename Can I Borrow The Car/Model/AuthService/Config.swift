//
//  Config.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-14.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import Foundation

struct Cell {
    static let carCell = "CarCell"
    static let borroewd = "BorrowedCarCell"
}

struct Segues {
    static let goToAddCar = "GoToAddCar"
    static let goToChosenCar = "GoToChosenCar"
    static let goToProfilePage = "GoToProfilePage"
}

struct Nibs {
    static let carCellHeader = "HeaderView"
    static let carCell = "CarCell"
    static let borrowCarView = "BorrowCarView"
}

struct FIRModelStrings {
    static let uid = "uid"
    static let model = "model"
    static let name = "name"
    static let licensePlate = "licensePlate"
    static let color = "color?"
    static let borrowed = "borrowed"
    
    static let groupName = "groupName"
    
    static let profileImageUrl = "profileImageUrl"    
    static let username = "username"
    static let usernameLowerCase = "username_lowercase"
    static let email = "email"
    
}

struct AuthConfig {
    static let FIRUrl = "https://caniborrowthecar.firebaseio.com/"
    static let storageUrl = "gs://caniborrowthecar.appspot.com"
    static let userUrl = "users"
    static let profilePictureUrl = "profile_image"
    static let carUrl = "cars"

    static let groupNameUrl = "groupeName"
    static let groupFeedUrl = "groupFeed"
    static let myGroupsUrl = "myGroups"
    
    static let myCarsUrl = "myCars"
    static let feedUrl = "feed"

    static let followers = "followers"
    static let following = "following"
}

struct Identifier {
    static let SignUpIdentifier = "SignUp"
    static let SignInIdentifier = "SignIn"
    static let AtHomeCarCell = "AtHomeCarCell"
    static let NotatHomeCarCell = "NotAtHomeCarCell"
}

struct Storyboard {
    static let SignInSB = "SignInViewController"
}

struct ImageName {
    static let placeHolderPhoto = "placeholder-photo"
    static let signInBackground = "background"
    static let placeholderProfileImage = "placeholderProfileImage"
}
