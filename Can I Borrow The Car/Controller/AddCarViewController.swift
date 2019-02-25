//
//  AddCarViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-14.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit
import ProgressHUD

class AddCarViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var carNameTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var licensePlateTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    
    var user: UserModel!
    var cars: [CarModel] = []
    var delegate : UpdateView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func saveCar() {
        API.UploadCar.uploadCar(name: carNameTextField.text!, model: modelTextField.text!, licencePlate: licensePlateTextField.text!, color: colorTextField!.text!, borrowed: true, uploaded: {
            ProgressHUD.showSuccess("Succes")
            self.delegate?.updateCarsFromDismiss()
            self.dismiss(animated: true, completion: nil)
        }) { (error) in
            ProgressHUD.showError(error)
        }
    }
    
    @IBAction func saveCarButton(_ sender: Any) {
        saveCar()
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
