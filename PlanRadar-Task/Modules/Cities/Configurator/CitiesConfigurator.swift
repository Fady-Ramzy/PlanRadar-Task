//
//  CitiesConfigurator.swift
//  PlanRadar-Task
//
//  Created by Fady Ramzy on 16/07/2021.
//

import Foundation
import UIKit

enum CitiesConfigurator: Configurator {
    
    // MARK: - Cases
    
    case list
    case details
    
    // MARK: - Properties
    
    var viewcontroller: UIViewController {
        switch self {
        case .list:
            let viewController = CitiesListViewController()
            let repository = CitiesRepository()
            let viewModel = CitiesListViewModel(repository: repository)
            viewController.viewModel = viewModel
            
            return viewController
        case .details:
            let viewController = CityDetailsViewController()
            let viewModel = CityDetailsViewModel()
            viewController.viewModel = viewModel
            
            return viewController
        }
    }
}
