//
//  UnknowError.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import Foundation
protocol ErrorBase: LocalizedError {
    var statusCode: Int? { get }
    var message: String? { get }
}

extension ErrorBase {
    var statusCode: Int? { return nil }
}

struct UnknownError: ErrorBase {
    let statusCode: Int?
    let message: String?
    
    init(statusCode: Int?, message: String) {
        self.statusCode = statusCode
        self.message = message
    }
    
    init(message: String) {
        self.statusCode = nil
        self.message = message
    }
    
    init() {
        self.statusCode = nil
        self.message = nil
    }
}
