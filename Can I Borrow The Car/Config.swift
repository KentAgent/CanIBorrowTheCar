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
}
