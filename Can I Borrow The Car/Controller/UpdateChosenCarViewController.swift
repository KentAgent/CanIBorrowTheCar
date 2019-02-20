//
//  UpdateChosenCarViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-20.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

protocol UpdateView {
    func reloadCarModel()
}

class UpdateChosenCarViewController: UIViewController {

    var carModel = CarModel()
    var categoryModel = CategoryModel()
    var carRealmManager = CarRealmManager()
    
    @IBOutlet weak var availableLable: UILabel!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var licencePlateLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var borrowedOfLabel: UILabel!
    @IBOutlet weak var availableButton: UIButton!
    var delegate : UpdateView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var selectedCar : Car? {
        didSet {
            DispatchQueue.main.async {
                self.fetchCar()
            }
        }
    }
    
    func fetchCar() {
        if selectedCar!.borrowedTo != nil {
            availableButton.setTitle("Return car", for: .normal)
            availableLable.textColor = UIColor.red
            availableLable.text! = "Car is not at home"
        } else {
            availableButton.setTitle("Borrow car", for: .normal)
            availableLable.textColor = UIColor.green
            availableLable.text! = "Car is at home"
        }
        carNameLabel.text! = selectedCar!.carName
        modelLabel.text! = selectedCar!.model
        colorLabel.text! = selectedCar!.color
        licencePlateLabel.text! = selectedCar!.licensePlate
    }

    func updateCar() -> Car{
        if selectedCar!.borrowedTo == nil && selectedCar!.borrowed == false {
            selectedCar!.borrowed = true
        } else {
            selectedCar!.borrowed = false
        }
        return selectedCar!

    }
    
    @IBAction func exitWindow(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            carRealmManager.update(update: updateCar) {
                self.dismiss(animated: true, completion: nil)
            }
        case 2:
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    
}
