//
//  WeatherCD+CoreDataProperties.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 05.10.2020.
//
//

import Foundation
import CoreData


extension WeatherCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherCD> {
        return NSFetchRequest<WeatherCD>(entityName: "WeatherCD")
    }

    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var timezone: String?
    @NSManaged public var timezoneOffset: Int64
    @NSManaged public var dailyForecast: NSSet?

}

// MARK: Generated accessors for dailyForecast
extension WeatherCD {

    @objc(addDailyForecastObject:)
    @NSManaged public func addToDailyForecast(_ value: WeatherCD)

    @objc(removeDailyForecastObject:)
    @NSManaged public func removeFromDailyForecast(_ value: WeatherCD)

    @objc(addDailyForecast:)
    @NSManaged public func addToDailyForecast(_ values: NSSet)

    @objc(removeDailyForecast:)
    @NSManaged public func removeFromDailyForecast(_ values: NSSet)

}

extension WeatherCD : Identifiable {
    
}
