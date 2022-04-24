//
//  SellUseCase.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import RxSwift
import CoreData

protocol SellUseCaseType {
    func getSellList(coreDataServiceType: CoreDataServiceType) -> Observable<[Item]>
}

class SellUseCase: SellUseCaseType {
    func getSellList(coreDataServiceType: CoreDataServiceType) -> Observable<[Item]> {
        return Observable.create { observer -> Disposable in
            do {
                try coreDataServiceType.initSellData()
            } catch {
                observer.onError(UnknownError(message: "SellUseCase can not init Sell data"))
                return Disposables.create()
            }
            
            do {
                let sells = try coreDataServiceType.fetchSellData().sorted(by: { $0.id < $1.id })
                observer.onNext(sells.map(Item.init))
                observer.onCompleted()
            } catch {
                observer.onError(UnknownError(message: "SellUseCase can not init Sell data"))
                return Disposables.create()
            }
            
            return Disposables.create()
        }
    }
}
