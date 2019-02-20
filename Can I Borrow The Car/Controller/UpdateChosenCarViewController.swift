//
//  UpdateChosenCarViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-20.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var selectedCar : Car? {
        didSet {
            DispatchQueue.main.async {
                self.fetchCar()
                print(self.selectedCar!.parent)
            }
        }
    }
    
    func fetchCar() {
        switch selectedCar?.isBorrowed {
        case true:
            availableButton.setTitle("Return car", for: .normal)
            availableLable.textColor = UIColor.red
            availableLable.text! = "Car is not at home"
        case false:
            availableButton.setTitle("Borrow car", for: .normal)
            availableLable.textColor = UIColor.green
            availableLable.text! = "Car is at home"
        default:
            break
        }
        carNameLabel.text! = selectedCar!.carName
        modelLabel.text! = selectedCar!.model
        colorLabel.text! = selectedCar!.color
        licencePlateLabel.text! = selectedCar!.licensePlate
        ownerLabel.text = selectedCar!.owner
    }

    func updateCar() {
        //Byt array om bilen lånas eller lämnas tillbaka
        switch selectedCar?.isBorrowed {
        case true:
            selectedCar?.isBorrowed = false
            print("Bilen är nu hemma")
            print(selectedCar!)
        case false:
            print("Bilen är nu lånad")
            selectedCar?.isBorrowed = true
            print(selectedCar!)
        default:
            break
        }
    }
    
    @IBAction func exitWindow(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            carRealmManager.update {
                updateCar()
            }
            dismiss(animated: true, completion: nil)
        case 2:
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    
}
