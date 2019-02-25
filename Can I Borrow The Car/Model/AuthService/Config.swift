//
//  Config.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-14.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import Foundation

struct Cell {
    static let category = "CarCell"
    static let notBorroewd = "NotBorrowedCarCell"
    static let borroewd = "BorrowedCarCell"
}

struct Segues {
    static let goToAddCar = "GoToAddCar"
    static let goToChosenCar = "GoToChosenCar"
}

struct Nibs {
    static let carCellHeader = "HeaderView"
    static let borrowCarView = "BorrowCarView"
}

struct FIRStrings {
    static let uid = "uid"
    static let model = "model"
    static let name = "name"
    static let licensePlate = "licensePlate"
    static let color = "color?"
    static let borrowed = "borrowed"
    
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
    static let commentUrl = "comments"
    static let carCommentUrl = "car-comment"
    static let myCarsUrl = "myCars"
    static let followers = "followers"
    static let following = "following"
    static let feed = "feed"
}

struct Identifier {
    static let SignUpIdentifier = "SignUp"
    static let SignInIdentifier = "SignIn"
}

struct Storyboard {
    static let SignInSB = "SignInViewController"
}

struct ImageName {
    static let placeHolderPhoto = "placeholder-photo"
    static let signInBackground = "background"
    static let placeholderProfileImage = "placeholderProfileImage"
}
