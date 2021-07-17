//
//  ViewLifeCycleProtocol.swift
//  PlanRadar-Task
//
//  Created by Fady Ramzy on 17/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewLifeCycleProtocol {
    func viewDidLoad() -> Observable<Void>
    func viewWillAppear() -> Observable<Void>
    func viewDidAppear() -> Observable<Void>
}

// MARK: - extensions

extension ViewLifeCycleProtocol {
    func viewDidLoad() -> Observable<Void> {
        return Observable.create { observer in
            observer.onNext(())
            
            return Disposables.create()
        }
    }
    
    func viewWillAppear() -> Observable<Void> {
        return Observable.create { observer in
            observer.onNext(())
            
            return Disposables.create()
        }
    }
    
    func viewDidAppear() -> Observable<Void> {
        return Observable.create { observer in
            observer.onNext(())
            
            return Disposables.create()
        }
    }
}
