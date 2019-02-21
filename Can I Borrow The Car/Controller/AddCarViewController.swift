//
//  AddCarViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-14.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class AddCarViewController: UIViewController, Storyboarded {
    
    var carModel = CarModel()
    var carRealmManager = CarRealmManager()
    
    @IBOutlet weak var carNameTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var licensePlateTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func saveCar() -> Car{
        let car = Car()
        car.carName = carNameTextField.text!
        car.model = modelTextField.text!
        car.color = colorTextField.text!
        car.licensePlate = licensePlateTextField.text!
        return car
    }
    
    @IBAction func saveCarButton(_ sender: Any) {
        self.carRealmManager.create(add: saveCar)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
