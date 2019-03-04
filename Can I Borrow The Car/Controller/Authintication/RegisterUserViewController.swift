//
//  RegisterUserViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-04.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit
import ProgressHUD

class RegisterUserViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    var selectImageFromPicker: UIImage?
    var isPicturePicked = false
    var samePassword = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeProfileImageOnClick()
        self.hideKeyboardWhenTappedAround()
    }
    
    private func completeUser() {
        checkTextFields {
            view.endEditing(true)
            ProgressHUD.show()
            setValueToFirebase {
                ProgressHUD.showSuccess("User created")
                self.performSegue(withIdentifier: Identifier.SignUpIdentifier, sender: nil)
            }
        }
    }
    
    private func checkTextFields(completion: () -> Void) {
        if labelsNotEmpty() == true {
            completion()
        }
    }
    
    private func setValueToFirebase(completion: @escaping () -> Void) {
        if let profileImg = self.selectImageFromPicker {
            if let imageData = profileImg.jpegData(compressionQuality: 0.1)  {
                AuthServiceSign.signUp(username: self.usernameTextField.text!, email: self.emailTextField.text!, password: self.passwordTextField.text!, firstName: self.firstNameTextField.text!, lastName: self.lastNameTextField.text!, imageData: imageData, signedIn: {
                    completion()
                }, onError: { (error) in
                    ProgressHUD.showError(error!)
                })
            }
        }
    }
    
    @IBAction func signUp_TouchUp(_ sender: Any) {
        completeUser()
    }

}
