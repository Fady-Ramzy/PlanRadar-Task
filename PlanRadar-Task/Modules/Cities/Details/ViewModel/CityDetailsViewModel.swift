//
//  CityDetailsViewModel.swift
//  PlanRadar-Task
//
//  Created by Fady Ramzy on 16/07/2021.
//

import Foundation
import RxCocoa
import RxSwift

protocol CityDetailsViewModelProtocol: ViewLifeCycleProtocol{
    var cityObservable: Observable<CityUIModel> { get }
}

class CityDetailsViewModel {
    
    // MARK: - Properties
    
    private let city: CityUIModel
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    
    init(city: CityUIModel) {
        self.city = city
    }
}

// MARK: - extensions

extension CityDetailsViewModel: CityDetailsViewModelProtocol {
    
    // MARK: - Properties
    
    var cityObservable: Observable<CityUIModel> {
        return Observable.create { observer in
            observer.onNext(self.city)
            
            return Disposables.create()
        }
    }
}
