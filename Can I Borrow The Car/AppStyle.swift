//
//  AppStyle.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-20.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import Foundation
import UIKit

class AppStyle {
    
    static func circleUIView(image: UIView) {
        image.layer.cornerRadius = image.frame.size.width/2
        image.clipsToBounds = true
    }
    
    static func cirlceUIImageView(image: UIImageView) {
        image.layer.cornerRadius = image.frame.size.width/2
        image.clipsToBounds = true
    }
}
