//
//  ProfileTabBar+TableView.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-06.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

extension ProfileTabBarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.AtHomeCarCell, for: indexPath) as! CarTableViewCell
        let car = myCars[indexPath.row]
        cell.car = car
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Nibs.carCellHeader) as! HeaderView
        
        headerView.sectionLabel.text = headerView.myCars
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func registerTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: Nibs.carCell, bundle: nil), forCellReuseIdentifier: Identifier.AtHomeCarCell)
        let headerNib = UINib.init(nibName: Nibs.carCellHeader, bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: Nibs.carCellHeader)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
}
