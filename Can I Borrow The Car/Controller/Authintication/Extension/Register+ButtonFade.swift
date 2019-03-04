//
//  SignUp+ButtonFade.swift
//  Instagram-FIR
//
//  Created by Kristoffer Knape on 2018-10-26.
//  Copyright © 2018 Kristoffer Knape. All rights reserved.
//

import Foundation
import ProgressHUD

extension RegisterUserViewController {

    func labelsNotEmpty() -> Bool {
        if (usernameTextField.text?.isEmpty)! {
            ProgressHUD.showError("Fill in user name")
            return false
        } else if (emailTextField.text?.isEmpty)! {
            ProgressHUD.showError("Fill in email")
            return false
        } else if (passwordTextField.text?.isEmpty)! {
            ProgressHUD.showError("Fill in password")
            return false
        } else if isPicturePicked == false {
            ProgressHUD.showError("Take a profile picture")
            return false
        } else if samePassword == false {
            ProgressHUD.showError("Not the same password")
            return Bool()
        } else {
            return true
        }
    }

}
