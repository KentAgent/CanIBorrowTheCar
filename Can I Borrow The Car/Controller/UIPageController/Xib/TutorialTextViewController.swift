//
//  TutorialPageViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-04.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class TutorialTextViewController: UIViewController {
    
    var tutorialModel = TutorialModel()

    @IBOutlet weak var textLabel: UILabel!
    
    var text: String? {
        didSet {
            self.textLabel?.text = text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
