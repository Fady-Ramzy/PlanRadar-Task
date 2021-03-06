//
//  WeatherResponse.swift
//  PlanRadar-Task
//
//  Created by Fady Ramzy on 18/07/2021.
//

import Foundation
import ObjectMapper

struct WeatherResponse: Mappable  {
    
    // MARK: - Properties
    
    var weather: [Weather]?
    var main: Main?
    var wind: Wind?
    
    // MARK: - Initializer
    
    init?(map: Map) {}
    
    init(weather: [Weather]?, main: Main?, wind: Wind?) {
        self.weather = weather
        self.main = main
        self.wind = wind
    }
    
    // MARK: - Mapping Methods
    
    mutating func mapping(map: Map) {
        weather <- map["weather"]
        main <- map["main"]
        wind <- map["wind"]
    }
}
