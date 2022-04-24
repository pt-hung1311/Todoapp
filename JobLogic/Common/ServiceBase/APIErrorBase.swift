//
//  APIErrorBase.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import UIKit

struct APIInvalidResponseError: ErrorBase {
    
    init() {
        
    }
    
    var message: String? {
        return NSLocalizedString("api.invalidResponseError",
                                 value: "Invalid server response",
                                 comment: "")
    }
}

struct APIUnknownError: ErrorBase {
    
    let statusCode: Int?
    
    init(statusCode: Int?) {
        self.statusCode = statusCode
    }
    
    var message: String? {
        return NSLocalizedString("api.unknownError",
                                 value: "Unknown API error",
                                 comment: "")
    }
}

