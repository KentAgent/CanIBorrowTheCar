//
//  MainCoordinator.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-15.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        //let vc = CarViewController.instantiate()
        //vc.coordinator = self
        //navigationController.pushViewController(vc, animated: true)
    }
    
    func addCar() {
        let child = AddCarCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func goBack() {
        // HUR GÅR JAG TILLBAKS???
        // 
    }
    
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from)
            else { return
        }
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        if let addCarViewController = fromViewController as? AddCarViewController {
            //childDidFinish(addCarViewController.coordinator)
        }
        
    }

    
}
