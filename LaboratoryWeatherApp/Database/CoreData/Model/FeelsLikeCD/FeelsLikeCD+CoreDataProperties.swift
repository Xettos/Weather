//
//  FeelsLikeCD+CoreDataProperties.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 05.10.2020.
//
//

import Foundation
import CoreData


extension FeelsLikeCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FeelsLikeCD> {
        return NSFetchRequest<FeelsLikeCD>(entityName: "FeelsLikeCD")
    }

    @NSManaged public var day: Double
    @NSManaged public var eve: Double
    @NSManaged public var morn: Double
    @NSManaged public var night: Double
    @NSManaged public var daily: DailyCD?

}

extension FeelsLikeCD : Identifiable {

}
