//
//  CitiesRepository.swift
//  PlanRadar-Task
//
//  Created by Fady Ramzy on 17/07/2021.
//

import Foundation

typealias APIResultHandler = (Any?, Error?) -> Void

protocol CitiesRepositoryProtocol {
    func fetchCityWeather(with city: String, completionHandler: @escaping APIResultHandler)
}

class CitiesRepository: CitiesRepositoryProtocol {
    
    // MARK: - Methods
    
    func fetchCityWeather(with city: String, completionHandler: @escaping APIResultHandler) {
        let apiClient = APIClient.sharedInstanceX() as! APIClient
        let request = CitiesRequest.details(city: city)
        apiClient.sendRequest(withURL: request.path, parameters: request.parameters, httpHeaders: request.httpHeaders, httpMethod: request.httpMethod.rawValue) { result, error in
            completionHandler(result, error)
        }
    }
}
