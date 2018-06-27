//
//  Storage.swift
//  SpaceAdventure
//
//  Created by Dimash Bekzhan on 6/26/18.
//  Copyright © 2018 Your School. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ success:Bool) -> Void

protocol isStorage {
    var items: [String: Int] { get set }
    func showItems()
    
    mutating func removeItem(named item: String, completionHandler: CompletionHandler)
    mutating func addItem(named item: String)
}

final class Cart: isStorage {
    var items: [String: Int] = [:]
}

final class Shop: isStorage, isPayable {
    
    var items: [String: Int] = [:]
    var balance: [String: Float] = [:]
}

// default implementation
extension isStorage {
    
    func showItems() {
        
        for (key, value) in items {
            print("\(key) in \(value) quantity")
        }
        
    }
    
    mutating func removeItem(named item: String, completionHandler: CompletionHandler) {
        
        
        if items[item] == 0 { items[item] = nil }
        guard var tempV = items[item] else {
            print("there is no such item")
            completionHandler(false)
            return
        }
        tempV -= 1
        items[item] = tempV
        completionHandler(true)
    }
    
    mutating func addItem(named item: String) {
        guard var tempV = items[item] else { items[item] = 1; return }
        tempV += 1
        items[item] = tempV
    }
}
