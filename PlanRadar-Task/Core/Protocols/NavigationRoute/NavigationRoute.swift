//
//  NavigationRoute.swift
//  PlanRadar-Task
//
//  Created by Fady Ramzy on 16/07/2021.
//

import Foundation
import UIKit

enum NavigationStyle {
    case push(animated: Bool)
    case presentModal(presentationStyle: UIModalPresentationStyle, animated: Bool, completionHandler: (()->Void)?)
}


protocol NavigationRoute {
    func navigate(to route: Router)
}

// MARK: - extensions

extension NavigationRoute where Self: UIViewController {
    func navigate(to route: Router) {
        switch route.navigationStyle {
        case .push(let animated):
            navigationController?.pushViewController(route.destinationViewController, animated: animated)
        case .presentModal(let presentationStyle, let animated, let completionHandler):
            let viewcontroller = route.destinationViewController
            viewcontroller.modalPresentationStyle = presentationStyle
            present(viewcontroller, animated: animated, completion: completionHandler)
        }
    }
}
