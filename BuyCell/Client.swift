//
//  Client.swift
//  SpaceAdventure
//
//  Created by Dimash Bekzhan on 6/26/18.
//  Copyright © 2018 Your School. All rights reserved.
//


import Foundation

class Client: isPayable {
    var name: String
    var balance: [String: Float]
    var cart: Cart
    
    
    init(name: String, balance: [String: Float], cart: Cart) {
        self.name = name
        self.balance = balance
        self.cart = cart
    }
    
    convenience init(name: String) {
        self.init(name: name, balance: [:], cart: Cart())
    }
}
