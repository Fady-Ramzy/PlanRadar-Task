//
//  CitiesRepositoryMock.swift
//  PlanRadar-TaskTests
//
//  Created by Fady Ramzy on 24/07/2021.
//

import Foundation
@testable import PlanRadar_Task

class CitiesRepositoryMock: CitiesRepositoryProtocol {
    
    // MARK: - Properties
    
    var weatherResponse: WeatherResponse?
    var error: Error?
    
    // MARK: - Methods
    
    func fetchCityWeather(with city: String, completionHandler: @escaping APIResultHandler) {
        completionHandler(weatherResponse, error)
    }
}
