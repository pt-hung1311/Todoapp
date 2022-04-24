//
//  Item.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import Foundation

struct Item: Codable {
    let id: Int
    let name: String
    let price: Int
    let quantity: Int
    let type: Int
    
    init(sell: Sell) {
        self.id = Int(sell.id)
        self.name = sell.name ?? ""
        self.price = Int(sell.price)
        self.quantity = Int(sell.quantity)
        self.type = Int(sell.type)
    }
    
    init(id: Int, name: String, price: Int, quantity: Int, type: Int) {
        self.id = id
        self.name = name
        self.price = price
        self.quantity = quantity
        self.type = type
    }
}
