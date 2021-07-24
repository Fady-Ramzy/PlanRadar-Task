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
    case details(city: CityUIModel)
    
    // MARK: - Properties
    
    var viewcontroller: UIViewController {
        switch self {
        case .list:
            let viewController = CitiesListViewController()
            let repository = CitiesRepository()
            let viewModel = CitiesListViewModel(repository: repository)
            viewController.viewModel = viewModel
            
            return viewController
        case .details(let city):
            let viewController = CityDetailsViewController()
            let viewModel = CityDetailsViewModel(city: city)
            viewController.viewModel = viewModel
            
            let navigationController = UINavigationController(rootViewController: viewController)
            
            return navigationController
        }
    }
}
