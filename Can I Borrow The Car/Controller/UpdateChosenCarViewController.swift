//
//  UpdateChosenCarViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-20.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit
import ProgressHUD

protocol UpdateView {
    func updateCarsFromDismiss()
}

class UpdateChosenCarViewController: UIViewController {
    var alert = Alert()
    
    var delegate : UpdateView?
    
    @IBOutlet weak var borrowCarView: BorrowCarView!
    @IBOutlet weak var visiualEffectView: UIVisualEffectView!
    var effect : UIVisualEffect?
    
    var selected = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        borrowCarView.awakeFromNib()
        borrowCar_TouchUpInside()
        cancelCar_TouchUpInside()
    }
    
    var selectedCar : CarModel? {
        didSet {
            DispatchQueue.main.async {
                print(self.selectedCar!.id!)
                AppStyle.circleUIView(image: self.borrowCarView.ownerView)
                self.showCarUI()
                self.showVisualEffect()
                self.animateIn()
            }
        }
    }
    
    func updateCar() {
        API.Car.updateCarValues(with: selectedCar!.id!, borrowed: updateCarBool(), uploaded: {
            ProgressHUD.showSuccess()
            self.delegate?.updateCarsFromDismiss()
            self.dismiss(animated: true, completion: nil)
        }) { (error) in
            ProgressHUD.showError(error)
        }

    }
    
    func showCarUI() {
        if selectedCar?.borrowed == true {
            borrowCarView.borrowCarButton.setTitle("Return", for: .normal)
        } else {
            borrowCarView.borrowCarButton.setTitle("Borrow", for: .normal)
        }
        borrowCarView.carName.text = selectedCar?.name
        borrowCarView.carModel.text = selectedCar?.model
        borrowCarView.carLicencePlate.text = selectedCar?.licensePlate?.uppercased()
        AppStyle.circleUIView(image: borrowCarView.ownerView)
    }
    
    func showVisualEffect() {
        effect = visiualEffectView.effect
        visiualEffectView.effect = nil
    }
    
    func animateIn() {
        UIView.animate(withDuration: 0.4) {
            self.visiualEffectView.effect = self.effect
        }
    }
    
    func borrowCar_TouchUpInside() {
        borrowCarView.borrowCarButton.addTapGestureRecognizer {
            self.updateCar()
        }
    }
    
    func cancelCar_TouchUpInside() { 
        borrowCarView.cancelCarButton.addTapGestureRecognizer {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func updateCarBool() -> Bool {
        if selectedCar!.borrowed == false {
            selectedCar!.borrowed = true
        } else {
            selectedCar!.borrowed = false
        }
        return selectedCar!.borrowed!
    }
    
}
