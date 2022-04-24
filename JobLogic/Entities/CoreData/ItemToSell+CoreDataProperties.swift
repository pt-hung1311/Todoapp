//
//  ItemToSell+CoreDataProperties.swift
//  JobLogic
//
//  Created by Pham Hung on 24/04/2022.
//
//

import Foundation
import CoreData


extension ItemToSell {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemToSell> {
        return NSFetchRequest<ItemToSell>(entityName: "ItemToSell")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var price: Int32
    @NSManaged public var quantity: Int16
    @NSManaged public var type: Int16

}

extension ItemToSell : Identifiable {

}
