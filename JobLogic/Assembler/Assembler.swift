//
//  Assembler.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import Foundation

protocol Assembler: AnyObject,
                    AppAssembler,
                    MainAssembler,
                    CallListAssembler,
                    BuyListAssembler,
                    SellListAssembler {
    
}

final class DefaultAssembler: Assembler {
    
}
