//
//  DailyCD+CoreDataProperties.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 05.10.2020.
//
//

import Foundation
import CoreData


extension DailyCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyCD> {
        return NSFetchRequest<DailyCD>(entityName: "DailyCD")
    }

    @NSManaged public var dewPoint: Int64
    @NSManaged public var dt: Double
    @NSManaged public var humidity: Int64
    @NSManaged public var pressure: Int64
    @NSManaged public var rain: Double
    @NSManaged public var sunrise: Int64
    @NSManaged public var sunset: Int64
    @NSManaged public var uvi: Double
    @NSManaged public var windDeg: Int64
    @NSManaged public var windSpeed: Int64
    @NSManaged public var feelsLike: FeelsLikeCD?
    @NSManaged public var temp: TempCD?
    @NSManaged public var weather: DailyCD?
    @NSManaged public var weatherElement: NSSet?
    @NSManaged public var dayTemp: Double
    @NSManaged public var nightTemp: Double
    @NSManaged public var weatherState: String


}

// MARK: Generated accessors for weatherElement
extension DailyCD {

    @objc(addWeatherElementObject:)
    @NSManaged public func addToWeatherElement(_ value: WeatherElementCD)

    @objc(removeWeatherElementObject:)
    @NSManaged public func removeFromWeatherElement(_ value: WeatherElementCD)

    @objc(addWeatherElement:)
    @NSManaged public func addToWeatherElement(_ values: NSSet)

    @objc(removeWeatherElement:)
    @NSManaged public func removeFromWeatherElement(_ values: NSSet)

}

extension DailyCD : Identifiable {

}
