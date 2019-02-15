//
//  AddCarCoordinator.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-15.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import Foundation
import UIKit

class AddCarCoordinator: Coordinator {
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = AddCarViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    
//    func didFinishSavingCar() {
//        parentCoordinator?.childDidFinish(self)
//    }
    
}
