//
//  LogInViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-04.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit
import ProgressHUD

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    private func signInOnComplete(completion: @escaping () -> (), error: @escaping (String) -> ()) {
        view.endEditing(true)
        ProgressHUD.show()
        AuthServiceSign.signIn(email: emailTextField.text!, password: passwordTextField.text!, signedIn: {
            completion()
        }) { (er) in
            error(er!)
        }
    }

    @IBAction func singIn_TouchUp(_ sender: Any) {
        signInOnComplete(completion: {
            ProgressHUD.showSuccess("Logged in")
            self.performSegue(withIdentifier: Identifier.SignInIdentifier, sender: nil)
        }) { (error) in
            ProgressHUD.showError(error)
        }
    }
    
}
