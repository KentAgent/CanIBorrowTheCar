//
//  UIApplication.swift
//  ToDoList
//
//  Created by Kristoffer Knape on 2019-02-13.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit
import Foundation

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
