//
//  AddCarViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-14.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class AddCarViewController: UIViewController, Storyboarded {
    
    weak var coordinator: AddCarCoordinator?
    var carModel = CarModel()
    var carRealmManager = CarRealmManager()
    
    @IBOutlet weak var carNameTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var licensePlateTextField: UITextField!
    @IBOutlet weak var ownerTextFIeld: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var isBorrowedSwitch: UISwitch!
    @IBOutlet weak var borrowedOfTextField: UITextField!
    
    var selectedCar : Car? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func saveCar() -> Car{
        let car = Car()
        car.carName = carNameTextField.text!
        car.model = modelTextField.text!
        car.color = colorTextField.text!
        car.licensePlate = licensePlateTextField.text!
        car.owner = ownerTextFIeld.text!
        car.isBorrowed = isBorrowedSwitch.isOn ? true : false
        return car
    }
    

    
    @IBAction func saveCarButton(_ sender: Any) {
        carRealmManager.create(complititon: saveCar)
        dismiss(animated: false, completion: nil)
    }
    
}
