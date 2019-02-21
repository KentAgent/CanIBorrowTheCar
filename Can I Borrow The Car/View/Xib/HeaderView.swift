//
//  HeaderView.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-21.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var sectionLabel: UILabel!
    override func draw(_ rect: CGRect) {
        backgroundView?.backgroundColor = UIColor.clear
    }


}
