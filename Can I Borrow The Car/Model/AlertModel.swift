//
//  AlertModel.swift
//  ToDoList
//
//  Created by Kristoffer Knape on 2019-02-13.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    static func alertField (title: String?, message: String?, addButtonTitle: String?, completion: @escaping (String) -> ()) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: title ?? nil, message: message ?? nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: addButtonTitle ?? nil, style: .default) { action in
            completion(textField.text!)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new..."
            textField = alertTextField
        }
        
        alert.addAction(cancel)
        alert.addAction(action)
        
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
        
    }
}
