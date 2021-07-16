//
//  Router.swift
//  PlanRadar-Task
//
//  Created by Fady Ramzy on 16/07/2021.
//

import Foundation
import UIKit

protocol Router {
    var destinationViewController: UIViewController { get }
    var navigationStyle: NavigationStyle { get }
}
