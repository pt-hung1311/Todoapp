//
//  APIInputBase.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import Alamofire
import Foundation

class APIInputBase {
    var headers: HTTPHeaders?
    var urlString: String
    var method: HTTPMethod
    var parameters: Parameters?
    
    init(urlString: String,
                parameters: [String: Any]?,
                method: HTTPMethod) {
        self.urlString = urlString
        self.parameters = parameters
        self.method = method
    }
}

extension APIInputBase {
    func description(isIncludedParameters: Bool) -> String {
        return "🌎 \(method.rawValue) \(urlString) Parameters: \(String(describing: parameters))"
    }
}
