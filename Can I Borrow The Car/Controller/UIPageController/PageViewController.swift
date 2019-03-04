//
//  RegisterPageViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-01.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class TutorialPageController: UIPageViewController {
    
    var vcArray = ["vc1", "vc2"]
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.nextViewController(vc: vcArray[0]),
                self.nextViewController(vc: vcArray[1])
        ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPageDataSource()
    }
    
    func setUpPageDataSource() {
        self.dataSource = self
        if let setViewController = orderedViewControllers.first {
            setViewControllers([setViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    func nextViewController(vc: String) -> UIViewController {
        return UIStoryboard(name: "RegisterPage", bundle: nil).instantiateViewController(withIdentifier: vc)
    }
    
}
