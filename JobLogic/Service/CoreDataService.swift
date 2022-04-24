//
//  CoreDataService.swift
//  JobLogic
//
//  Created by Pham Hung on 24/04/2022.
//

import CoreData

protocol CoreDataServiceType {
    func initSellData() throws
    func fetchSellData() throws -> [ItemToSell]
}

class CoreDataService: CoreDataServiceType {
    lazy var coreDataStack = CoreDataStack(modelName: "JobLogic")
    
    func initSellData() throws {
        let fetch: NSFetchRequest<ItemToSell> = ItemToSell.fetchRequest()
        
        let sellCount = (try? coreDataStack.managedContext.count(for: fetch)) ?? 0
        
        if sellCount > 0 {
            return
        }
        let items = [
            Item(id: 1, name: "iPhone X", price: 150000, quantity: 1, type: 2),
            Item(id: 2, name: "TV", price: 38000, quantity: 2, type: 2),
            Item(id: 3, name: "Table", price: 12000, quantity: 1, type: 2)
        ]
        
        for item in items {
            let entity = NSEntityDescription.entity(forEntityName: "ItemToSell",
                                                    in: coreDataStack.managedContext)!
            let sell = ItemToSell(entity: entity,
                                  insertInto: coreDataStack.managedContext)
            
            sell.id = Int16(item.id)
            sell.name = item.name
            sell.price = Int32(item.price)
            sell.quantity = Int16(item.quantity)
            sell.type = Int16(item.type)
        }
        
        try coreDataStack.managedContext.save()
    }
    
    func fetchSellData() throws -> [ItemToSell] {
        let fetchRequest: NSFetchRequest<ItemToSell> = ItemToSell.fetchRequest()
        let results = try coreDataStack.managedContext.fetch(fetchRequest)
        return results
    }
}
