//
//  TempCD+CoreDataProperties.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 05.10.2020.
//
//

import Foundation
import CoreData


extension TempCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TempCD> {
        return NSFetchRequest<TempCD>(entityName: "TempCD")
    }

    @NSManaged public var day: Double
    @NSManaged public var eve: Double
    @NSManaged public var max: Double
    @NSManaged public var min: Double
    @NSManaged public var morn: Double
    @NSManaged public var night: Double
    @NSManaged public var daily: DailyCD?

}

extension TempCD : Identifiable {

}
