/*

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike
4.0 International License, by Yong Bakos.

*/

import Foundation


// Shop instance
var shop = Shop()
shop.balance = [ "cash" : 500, "card" : 400, "bitcoin" : 5]
shop.items = [
    Good(name: "apple", price: 20) : 2,
    Good(name: "pineapple", price: 30) : 3,
    Good(name: "tomato", price: 10) : 5
            ]
// Bank instance
let bank = Bank()

// MARK: - Begin
print("Welcome to the shop. What's your name?")

let name = getln()
// Client instance
var client = Client(name: name)

// Setting delegates
shop.delegate = client.cart
client.cart.delegate = shop

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
                        print("success")
                        client.cart.addItem(named: inp)
                    }
                })
            }
        }
    case "ch":
        let capacity = bank.canPay(giver: client, currency: currentPayMethod!)
        switch capacity {
        case .success:
            bank.executeTransaction(from: &client, to: &shop)
            client.balance.forEach({ (key, balance) in
                print("Now you have \(balance) in \(key)")
            })
            shop.balance.forEach({ (key, balance) in
                print("Now we have \(balance) in \(key)")
            })
            
            client.cart.items.removeAll()
        case .failure(let message):
            print(message)
        }
    default:
        continue
    }
}


