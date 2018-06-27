//
//  Bank.swift
//  SpaceAdventure
//
//  Created by Dimash Bekzhan on 6/26/18.
//  Copyright © 2018 Your School. All rights reserved.
//

import Foundation
// check if client has enough money
protocol isPayable {
    var balance: [String: Float] { get set }
}

class Bank {
    func executeTransfer(from giver: isPayable, to receiver: isPayable) {
        
    }
}
