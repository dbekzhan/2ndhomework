//
//  Good.swift
//  SpaceAdventure
//
//  Created by Dimash Bekzhan on 6/26/18.
//  Copyright © 2018 Your School. All rights reserved.
//

import Foundation


struct Good: Hashable {
    let name: String
    let price: Float
    
    var hashValue: Int {
        return name.hashValue
    }
    
    static func == (lhs: Good, rhs: Good) -> Bool {
        return lhs.name == rhs.name && lhs.price == rhs.price
    }
}
