//
//  RegisterPageViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-01.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

protocol TutorialTextPageViewControllerDelegate {
    func setupPageController(numberOfPages: Int)
    func turnPageController(to index: Int)
}

class TutorialPageController: UIPageViewController {
    
    var tutorialText : [String]?

    var pageViewControllerDelegate: TutorialTextPageViewControllerDelegate?
    
    lazy var orderedViewControllers: [UIViewController] = {
        let storyboard = UIStoryboard(name: "Authintication", bundle: nil)
        var controllers = [UIViewController]()
        
        if let tutorialText = Tutorial.text {
            for text in tutorialText {
                let tutorialTextVC = storyboard.instantiateViewController(withIdentifier: "vc1")
                controllers.append(tutorialTextVC)
            }
        }
        
        self.pageViewControllerDelegate?.setupPageController(numberOfPages: self.orderedViewControllers.count)
        
        return controllers
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegate()
        self.turnToPage(index: 0)
    }
    
    private func setUpDelegate() {
        self.tutorialText = Tutorial.text
        self.dataSource = self
        self.delegate = self
    }
    
    private func turnToPage(index: Int) {
        let controller = orderedViewControllers[index]
        
        var direction = UIPageViewController.NavigationDirection.forward
        if let currentVC = viewControllers?.first {
            let currentIndex = orderedViewControllers.index(of: currentVC)
            if currentIndex! > index {
                direction = .reverse
            }
        }
        setViewControllers([controller], direction: direction, animated: true, completion: nil)
        self.configureDisplaying(viewController: controller)
    }
    
    func configureDisplaying(viewController: UIViewController) {
        for (index, vc) in orderedViewControllers.enumerated() {
            if viewController === vc {
                if let tutorialTextVC = viewController as? TutorialTextViewController {
                    tutorialTextVC.textLabel.text = self.tutorialText?[index]
                    self.pageViewControllerDelegate?.turnPageController(to: index)
                }
            }
        }
    }
    
    
    
}
