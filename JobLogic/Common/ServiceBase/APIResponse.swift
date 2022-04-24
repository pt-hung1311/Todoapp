//
//  APIResponse.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import Foundation

struct APIResponse<T> {
    var header: ResponseHeader?
    var data: T
    
    init(header: ResponseHeader?, data: T) {
        self.header = header
        self.data = data
    }
}
