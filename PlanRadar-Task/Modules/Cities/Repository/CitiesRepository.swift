//
//  CitiesRepository.swift
//  PlanRadar-Task
//
//  Created by Fady Ramzy on 17/07/2021.
//

import Foundation
import CoreData

typealias APIResultHandler = (WeatherResponse?, Error?) -> Void

protocol CitiesRepositoryProtocol {
    func fetchCityWeather(with city: String, completionHandler: @escaping APIResultHandler)
    func saveObject(viewContext: NSManagedObjectContext, completionHandler: (_ isSaved: Bool, _ error: Error?) -> Void)
    func deleteFromContext(with object: NSManagedObject, viewContext: NSManagedObjectContext, completionHandler: (_ isDeleted: Bool, _ error: Error?) -> Void)
    func fetchLocalCitiesWeatherData(with viewcontext: NSManagedObjectContext, fetchRequest: NSFetchRequest<NSFetchRequestResult>, completionHandler: (_ results: [NSFetchRequestResult]?, _ error: Error?) -> Void)
}

class CitiesRepository: CitiesRepositoryProtocol {
    // MARK: - Methods
    
    func fetchLocalCitiesWeatherData(with viewcontext: NSManagedObjectContext, fetchRequest: NSFetchRequest<NSFetchRequestResult>, completionHandler: ([NSFetchRequestResult]?, Error?) -> Void) {
        do {
            let requestResults =  try viewcontext.fetch(fetchRequest) as! [NSFetchRequestResult]
            completionHandler(requestResults, nil)
        } catch {
            completionHandler(nil, error)
        }
    }
    
    func fetchCityWeather(with city: String, completionHandler: @escaping APIResultHandler) {
        let apiClient = APIClient.sharedInstanceX() as! APIClient
        let request = CitiesRequest.details(city: city)
        apiClient.sendRequest(withURL: request.path, parameters: request.parameters, httpHeaders: request.httpHeaders, httpMethod: request.httpMethod.rawValue) { result, error in
            if error != nil {
                completionHandler(nil, error)
            } else {
                let weatherResponse = WeatherResponse(JSON: result as! [String: Any])
                completionHandler(weatherResponse, nil)
            }
        }
    }
    
    func saveObject(viewContext: NSManagedObjectContext, completionHandler: (_ isSaved: Bool, _ error: Error?) -> Void) {
        do {
            try viewContext.save()
            completionHandler(true, nil)
        } catch {
            completionHandler(false, error)
        }
    }
    
    func deleteFromContext(with object: NSManagedObject, viewContext: NSManagedObjectContext, completionHandler: (_ isDeleted: Bool, _ error: Error?) -> Void) {
        viewContext.delete(object)
        do {
            try viewContext.save()
            completionHandler(true, nil)
        } catch {
            completionHandler(false, error)
        }
    }
}
