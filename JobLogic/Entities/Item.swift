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
    
    init(itemToSell: ItemToSell) {
        self.id = Int(itemToSell.id)
        self.name = itemToSell.name ?? ""
        self.price = Int(itemToSell.price)
        self.quantity = Int(itemToSell.quantity)
        self.type = Int(itemToSell.type)
    }
    
    init(id: Int, name: String, price: Int, quantity: Int, type: Int) {
        self.id = id
        self.name = name
        self.price = price
        self.quantity = quantity
        self.type = type
    }
}
