//
//  CitiesRequest.swift
//  PlanRadar-Task
//
//  Created by Fady Ramzy on 17/07/2021.
//

import Foundation

enum CitiesRequest: Request {
    
    // MARK: - Cases
    
    case details(city: String)
    case weatherIcon(iconId: String)

    // MARK: - Properties
    
    var path: String {
        switch self {
        case .details(let cityName):
            return "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=f5cb0b965ea1564c50c6f1b74534d823"
        case .weatherIcon(let iconId):
            return "http://openweathermap.org/img/w/\(iconId).png"
        }
    }

    var parameters: [String : Any]? {
        return nil
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .details:
            return .get
        case .weatherIcon:
            return .get
        }
    }
    
    var httpHeaders: [String : Any]? {
        return nil
    }
}
