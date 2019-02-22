//
//  BorrowCarView.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-22.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

@IBDesignable
class BorrowCarView: UIView {

    @IBOutlet var borrowCarView: UIView!
    @IBOutlet weak var ownerView: UIImageView!
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var carModel: UILabel!
    @IBOutlet weak var carLicencePlate: UILabel!
    @IBOutlet weak var carColorLine: UIView!
    
    @IBOutlet weak var cancelCarButton: UIImageView!
    @IBOutlet weak var borrowCarButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commitInit()
    }
    
    private func commitInit() {
        let bundle = Bundle(for: BorrowCarView.self)
        bundle.loadNibNamed(Nibs.borrowCarView, owner: self, options: nil)
        addSubview(borrowCarView)
        borrowCarView.frame = self.bounds
        borrowCarView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
}
