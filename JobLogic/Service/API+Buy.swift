//
//  API+Buy.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import RxSwift

extension API {
    func getBuyList(_ input: GetBuyListInput) -> Observable<[Item]> {
        return request(input)
    }
}

extension API {
    final class GetBuyListInput: APIInput {
        init() {
            super.init(urlString: API.Urls.getBuyList,
                       parameters: nil,
                       method: .get)
        }
    }
}
