//
//  APIInput.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import Alamofire

class APIInput: APIInputBase {
    override init(urlString: String,
                  parameters: [String: Any]?,
                  method: HTTPMethod) {
        super.init(urlString: urlString,
                   parameters: parameters,
                   method: method)
        self.headers = [
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json"
        ]
    }
}
