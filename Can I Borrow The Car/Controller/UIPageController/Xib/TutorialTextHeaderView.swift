//
//  TutorialTextHeaderView.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-04.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class TutorialTextHeaderView: UIView {
    
    @IBOutlet weak var pageControl : UIPageControl!
    
}

extension TutorialTextHeaderView: TutorialTextPageViewControllerDelegate {
    
    func setupPageController(numberOfPages: Int) {
        pageControl.numberOfPages = numberOfPages
    }
    
    func turnPageController(to index: Int) {
        pageControl.currentPage = index
    }
    
    
}
