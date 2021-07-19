//
//  RootRouter.swift
//  PlanRadar-Task
//
//  Created by Fady Ramzy on 17/07/2021.
//

import Foundation
import UIKit

enum RootRouter: Router {
    
    // MARK: - Cases
    
    case root
    
    // MARK: - Properties
    
    var destinationViewController: UIViewController {
        let rootViewController = CitiesConfigurator.list.viewcontroller
        let rootNavigationController = UINavigationController(rootViewController: rootViewController)
        
        return rootNavigationController
    }
    
    var navigationStyle: NavigationStyle {
        return .push(animated: true)
    }
}
