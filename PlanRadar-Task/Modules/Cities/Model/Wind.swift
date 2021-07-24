//
//  Wind.swift
//  PlanRadar-Task
//
//  Created by Fady Ramzy on 18/07/2021.
//

import Foundation
import ObjectMapper

struct Wind: Mappable {
    
    // MARK: - Properties
    
    var speed: Double?
    
    // MARK: - Initializer
    
    init?(map: Map) {}
    
    init(speed: Double?) {
        self.speed = speed
    }
    
    // MARK: - Mapping Methods
    
    mutating func mapping(map: Map) {
        speed <- map["speed"]
    }
}
