//
//  LoadingIndicator.swift
//  PlanRadar-Task
//
//  Created by Fady Ramzy on 24/07/2021.
//

import Foundation

protocol LoadingIndicatorProtocol {
    func showLoadingIndicator()
    func hideLoadingIndicator()
}

extension LoadingIndicatorProtocol {
    func showLoadingIndicator() {
        SVProgressHUD.show()
    }
    
    func hideLoadingIndicator() {
        SVProgressHUD.dismiss()
    }
}
