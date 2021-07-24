//
//  Weather.swift
//  PlanRadar-Task
//
//  Created by Fady Ramzy on 18/07/2021.
//

import Foundation
import ObjectMapper

struct Weather: Mappable {
    
    // MARK: - Properties
    
    var description: String?
    var icon: String?
    
    // MARK: - Initializer
    
    init?(map: Map) {}
    
    init(description: String?, icon: String?) {
        self.description = description
        self.icon = icon
    }
    
    // MARK: - Mapping Methods
    
    mutating func mapping(map: Map) {
        description <- map["description"]
        icon <- map["icon"]
    }
}
