//
//  Main.swift
//  PlanRadar-Task
//
//  Created by Fady Ramzy on 18/07/2021.
//

import Foundation
import ObjectMapper

struct Main: Mappable {
    
    // MARK: - Properties
    
    var temprature: Double?
    var humidity: Int?
    
    // MARK: - Initializer
    
    init?(map: Map) {}
    
    // MARK: - Mapping Methods
    
    mutating func mapping(map: Map) {
        temprature <- map["temp"]
        humidity <- map["humidity"]
    }
}
