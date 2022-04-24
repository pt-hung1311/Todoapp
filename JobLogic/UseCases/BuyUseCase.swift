//
//  BuyUseCase.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import RxSwift

protocol BuyUseCaseType {
    func getBuyList() -> Observable<[Item]>
}

class BuyUseCase: BuyUseCaseType {
    func getBuyList() -> Observable<[Item]> {
        let input = API.GetBuyListInput()
        
        return API.shared.getBuyList(input)
    }
}
