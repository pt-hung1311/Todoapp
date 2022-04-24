//
//  APIError.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import Foundation

struct APIResponseError: ErrorBase {
    var message: String?
    
    let statusCode: Int?
    
    var errorDescription: String? {
        return message
    }
}
