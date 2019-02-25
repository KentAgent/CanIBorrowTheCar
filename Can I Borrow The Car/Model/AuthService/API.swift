//
//  API.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-25.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import Foundation

class API {
    static var User = LoadUser()
    static var Car = CarModel()
    static var LoadCar = LoadCarModel()
    static var UploadCar = UploadCarModel()
    static let Feed = FeedAPI()
    static var MyCar = UserCar()
}
