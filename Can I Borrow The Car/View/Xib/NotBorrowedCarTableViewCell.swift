//
//  BorrowedCarTableViewCell.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-20.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class NotBorrowedCarTableViewCell: UITableViewCell {

    
    @IBOutlet weak var carColorView: UIView!
    @IBOutlet weak var carLicencePlatelabel: UILabel!
    @IBOutlet weak var carModelLabel: UILabel!
    
    var car: Car? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        carLicencePlatelabel.text = car?.licensePlate
        carModelLabel.text = car?.model
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        AppStyle.circleUIView(image: carColorView)
    }
    
}