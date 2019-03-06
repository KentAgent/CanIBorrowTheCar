
//
//  MainPageViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-04.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {
    
    @IBOutlet weak var tutorialTextHeaderView: TutorialTextHeaderView!
    var pageViewController: UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var user : UserModel?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AuthServiceSign.autoSignIn { (user) in
            self.user = user
            self.performSegue(withIdentifier: Identifier.SignInIdentifier, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sigedInVc = segue.destination as? TabBarController {
            sigedInVc.user = user
        }
    }
}
