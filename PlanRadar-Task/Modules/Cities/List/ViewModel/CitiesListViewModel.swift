//
//  CitiesListViewModel.swift
//  PlanRadar-Task
//
//  Created by Fady Ramzy on 16/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol CitiesListViewModelProtocol: ViewLifeCycleProtocol {
    
}

class CitiesListViewModel {
    
    // MARK: - Properties
    
    var repository: CitiesRepositoryProtocol!
    let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    
    init(repository: CitiesRepositoryProtocol) {
        self.repository = repository
        subscribeOnEvents()
    }
    
    
    func subscribeOnEvents() {
        viewDidLoad().subscribe(onNext: {
            
        }).disposed(by: disposeBag)
    }
}

// MARK: - extensions

extension CitiesListViewModel: CitiesListViewModelProtocol {
    
}

