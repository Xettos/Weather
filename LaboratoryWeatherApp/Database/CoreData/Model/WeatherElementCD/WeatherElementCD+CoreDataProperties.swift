//
//  WeatherElementCD+CoreDataProperties.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 05.10.2020.
//
//

import Foundation
import CoreData


extension WeatherElementCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherElementCD> {
        return NSFetchRequest<WeatherElementCD>(entityName: "WeatherElementCD")
    }

    @NSManaged public var descript: String?
    @NSManaged public var icon: String?
    @NSManaged public var id: Int64
    @NSManaged public var main: String?
    @NSManaged public var daily: DailyCD?

}

extension WeatherElementCD : Identifiable {

}
