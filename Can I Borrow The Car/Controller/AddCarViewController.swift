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
    
    var selectedCar : Car? {
        didSet {
            carModel.cars = carRealmManager.load()
            DispatchQueue.main.async {
                self.updateView(selectedCar: self.selectedCar!)
            }
        }
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
    
    func updateCar() -> Car{
        selectedCar!.carName = carNameTextField.text!
        selectedCar!.model = modelTextField.text!
        selectedCar!.color = colorTextField.text!
        selectedCar!.licensePlate = licensePlateTextField.text!
        selectedCar!.owner = ownerTextFIeld.text!
        selectedCar!.isBorrowed = isBorrowedSwitch.isOn ? true : false
        selectedCar!.borrowedOf = borrowedOfTextField.text!
        return selectedCar!
    }
    
    func updateView(selectedCar: Car) {
        carNameTextField.text! = selectedCar.carName
        modelTextField.text! = selectedCar.model
        colorTextField.text! = selectedCar.color
        licensePlateTextField.text! = selectedCar.licensePlate
        ownerTextFIeld.text! = selectedCar.owner
        if selectedCar.isBorrowed == true {
            isBorrowedSwitch.isOn = true
        } else {
            isBorrowedSwitch.isOn = false
        }
        borrowedOfTextField.text! = selectedCar.borrowedOf
    }
    
    @IBAction func saveCarButton(_ sender: Any) {
        if selectedCar == nil {
            self.carRealmManager.create {
                saveCar()
            }
        } else {
            carRealmManager.update {
                selectedCar = updateCar()
            }
        }

        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
