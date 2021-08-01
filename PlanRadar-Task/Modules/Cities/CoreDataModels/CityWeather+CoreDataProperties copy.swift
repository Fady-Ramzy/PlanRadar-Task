//
//  CityWeather+CoreDataProperties.swift
//  
//
//  Created by Fady Ramzy on 30/07/2021.
//
//

import Foundation
import CoreData


extension CityWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityWeather> {
        return NSFetchRequest<CityWeather>(entityName: "CityWeather")
    }

    @NSManaged public var cityName: String?
    @NSManaged public var temprature: Double
    @NSManaged public var weatherDescription: String?
    @NSManaged public var humidity: Int64
    @NSManaged public var windSpeed: Double
    @NSManaged public var icon: String?
    @NSManaged public var saveDate: Date?

}
