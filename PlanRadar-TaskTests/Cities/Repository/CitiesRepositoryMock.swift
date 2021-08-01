//
//  CitiesRepositoryMock.swift
//  PlanRadar-TaskTests
//
//  Created by Fady Ramzy on 24/07/2021.
//

import Foundation
import CoreData
@testable import PlanRadar_Task

class CitiesRepositoryMock: CitiesRepositoryProtocol {
    
    // MARK: - Properties
    
    var weatherResponse: WeatherResponse?
    var error: Error?
    
    // MARK: - Methods
    
    func saveObject(viewContext: NSManagedObjectContext, completionHandler: (Bool, Error?) -> Void) {
        
    }
    
    func deleteFromContext(with object: NSManagedObject, viewContext: NSManagedObjectContext, completionHandler: (Bool, Error?) -> Void) {
        
    }
    
    func fetchCityWeather(with city: String, completionHandler: @escaping APIResultHandler) {
        completionHandler(weatherResponse, error)
    }
}
