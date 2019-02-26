//
//  AddCarViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-14.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit
import ProgressHUD

class AddCarViewController: UIViewController {
    
    @IBOutlet weak var carNameTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var licensePlateTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    
    var user: UserModel!
    var cars: [CarModel] = []
    var delegate : UpdateView?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavigationBarUI()
    }
    
    func saveCar() {
        API.Car.uploadCarValues(name: carNameTextField.text!, model: modelTextField.text!, licencePlate: licensePlateTextField.text!, color: colorTextField!.text!, borrowed: false, uploaded: {
            ProgressHUD.showSuccess("Succes")
            self.delegate?.updateCarsFromDismiss()
            self.dismiss(animated: true, completion: nil)
        }) { (error) in
            ProgressHUD.showError(error)
        }
    }
    
    func updateNavigationBarUI() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    @IBAction func saveCarButton(_ sender: Any) {
        saveCar()
    }
    
}
