//
//  CitiesRouter.swift
//  PlanRadar-Task
//
//  Created by Fady Ramzy on 16/07/2021.
//

import Foundation
import UIKit

enum CitiesRouter: Router {
    
    // MARK: - Cases
    
    case list
    case details(city: CityUIModel)
    
    // MARK: - Properties
    
    var destinationViewController: UIViewController {
        switch self {
        case .list:
            return CitiesConfigurator.list.viewcontroller
        case .details(let city):
            return CitiesConfigurator.details(city: city).viewcontroller
        }
    }
    
    var navigationStyle: NavigationStyle {
        switch self {
        case .list:
            return .push(animated: true)
        case .details:
            return .presentModal(presentationStyle: .fullScreen, animated: true, completionHandler: nil)
        }
    }
}
