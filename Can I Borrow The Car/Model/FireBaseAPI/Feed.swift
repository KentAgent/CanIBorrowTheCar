//
//  Feed.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-02-25.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import Foundation
import Firebase


class FeedAPI {
    var refFeed = Database.database().reference().child(AuthConfig.feed)
    
    func observeFeed(with id: String, completion: ((CarModel) -> ())? = nil) {
        refFeed.child(id).observe(.childAdded) { (snapshot) in
            let key = snapshot.key
            API.LoadCar.observeCar(with: key, completion: { (car) in
                completion?(car)
            })
        }
    }
}
