//
//  Storyboarded.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-15.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
