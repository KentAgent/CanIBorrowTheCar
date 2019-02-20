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
    var categoryModel = CategoryModel()
    var carRealmManager = CarRealmManager()
    
    @IBOutlet weak var carNameTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var licensePlateTextField: UITextField!
    @IBOutlet weak var ownerTextFIeld: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var isBorrowedSwitch: UISwitch!
    @IBOutlet weak var borrowedOfTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func saveCar(){
        let car = Car()
        car.carName = carNameTextField.text!
        car.model = modelTextField.text!
        car.color = colorTextField.text!
        car.licensePlate = licensePlateTextField.text!
        car.owner = ownerTextFIeld.text!
        car.isBorrowed = isBorrowedSwitch.isOn ? true : false
        car.borrowedOf = borrowedOfTextField.text!
        car.isBorrowed == true ? categoryModel.categories![1].cars.append(car) : categoryModel.categories![0].cars.append(car)
    }
    
    @IBAction func saveCarButton(_ sender: Any) {
        self.carRealmManager.create {
            saveCar()
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
