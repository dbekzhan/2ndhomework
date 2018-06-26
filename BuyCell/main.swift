/*

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike
4.0 International License, by Yong Bakos.

*/

import Foundation


// Shop instance
var shop = Shop()
shop.balance = [ "cash" : 500, "card" : 400, "bitcoin" : 5]
shop.items = [ "apple" : 2, "pineapple" : 3, "potato" : 5]
// Bank instance
let bank = Bank()

// MARK: - Begin
print("Welcome to the shop. What's your name?")

let name = getln()
// Client instance
var client = Client(name: name)

// Set balance
for payMethod in Payment.cases {
    var input: Float?
    
    repeat {
        print("\(client.name), your balance in \(payMethod.rawValue) is ")
        input = Float(getln())
    } while input == nil

    client.balance.updateValue(input!, forKey: payMethod.rawValue)
}

// Choose current payment method
var currentPayMethod: Payment?

repeat {
    print("Now choose current payment type: cash, card, bitcoin")
    let inp = getln()
    currentPayMethod = Payment(rawValue: inp)
} while currentPayMethod == nil


// MARK: -Main cycle
while true {
    print("list of available commands: cart, assortiment, checkout (ca | as | ch)")
    let command = getln().lowercased()
    
    switch command {
    case "ca":
        if client.cart.items.isEmpty { print("it's empty") } else {
            client.cart.showItems()
            if didAgree(toQuestion: "remove some items?") {
                print("what item")
                let inp = getln()
                client.cart.removeItem(named: inp, completionHandler: { (success) in
                    if success {
                        shop.addItem(named: inp)
                    }
                })
                
            }
        }
    case "as":
        if shop.items.isEmpty { print("it's empty") } else {
            shop.showItems()
            if didAgree(toQuestion: "add to cart items?") {
                print("what item")
                let inp = getln()
                shop.removeItem(named: inp, completionHandler: { (success) in
                    if success {
                        client.cart.addItem(named: inp)
                    }
                })
            }
        }
    case "ch":
        bank.executeTransfer(from: client, to: shop)
    default:
        continue
    }
}




