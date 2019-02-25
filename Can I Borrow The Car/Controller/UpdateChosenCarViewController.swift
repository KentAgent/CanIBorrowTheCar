//
//  UpdateChosenCarViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-20.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

protocol UpdateView {
    func userUpdateCar()
}

class UpdateChosenCarViewController: UIViewController {
    
    var delegate : UpdateView?
    
    @IBOutlet weak var borrowCarView: BorrowCarView!
    @IBOutlet weak var visiualEffectView: UIVisualEffectView!
    var effect : UIVisualEffect?
    
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
                self.updateCarUI()
                self.updateVisualEffect()
                self.animateIn()
            }
        }
    }
    
    func updateCarUI() {
        if selectedCar?.borrowed != nil {
            borrowCarView.borrowCarButton.setTitle("Return", for: .normal)
        } else {
            borrowCarView.borrowCarButton.setTitle("Borrow", for: .normal)
        }
        borrowCarView.carName.text = selectedCar?.name
        borrowCarView.carModel.text = selectedCar?.model
        borrowCarView.carLicencePlate.text = selectedCar?.licensePlate?.uppercased()
        AppStyle.circleUIView(image: borrowCarView.ownerView)
    }
    
    func updateVisualEffect() {
        effect = visiualEffectView.effect
        visiualEffectView.effect = nil
    }
    
    func animateIn() {
        UIView.animate(withDuration: 0.4) {
            self.visiualEffectView.effect = self.effect
        }
    }

    @IBAction func exitWindow(_ sender: UIButton) {
        switch sender.tag {
        case 1:
//            carRealmManager.update(update: updateCar) {
//                self.delegate?.userUpdateCar()
//            }
            self.dismiss(animated: true, completion: nil)
        case 2:
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    
    func borrowCar_TouchUpInside() {
//       // borrowCarView.borrowCarButton.addTapGestureRecognizer {
//            print("borrow")
//            self.carRealmManager.update(update: self.updateCar) {
//                self.delegate?.userUpdateCar()
//            }
//            self.dismiss(animated: true, completion: nil)
//        }
    }
    
    func cancelCar_TouchUpInside() {
        borrowCarView.cancelCarButton.addTapGestureRecognizer {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
//    func updateCar() -> Car {
//        if selectedCar!.borrowed == false {
//            selectedCar!.borrowed = true
//        } else {
//            selectedCar!.borrowed = false
//        }
//        return selectedCar!
//    }
    
}
