//
//  WeatherClasses.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 11.10.2020.
//
import Foundation
import CoreData

enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}

class WeatherItem: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case daily
    }
    
    required convenience init(from decoder: Decoder) throws {
        
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.daily = try container.decode(Set<DailyWeather>.self, forKey: .daily) as NSSet
    }
}

class DailyWeather: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case temp
        case dt
        case weather
    }
    
    required convenience init(from decoder: Decoder) throws {
        
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(Int64.self, forKey: .dt)
        self.temperature = try container.decode(WeatherTemperature.self, forKey: .temp)
        self.weatherElement = try container.decode(Set<WeatherElements>.self, forKey: .weather) as NSSet
    }
}

class WeatherElements: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case main
        case icon
    }
    
    required convenience init(from decoder: Decoder) throws {
        
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.weatherState = try container.decode(String.self, forKey: .main)
        self.iconId = try container.decode(String.self, forKey: .icon)
    }
}

class WeatherTemperature: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case day
        case night
    }
    
    required convenience init(from decoder: Decoder) throws {
        
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.day = try container.decode(Double.self, forKey: .day)
        self.night = try container.decode(Double.self, forKey: .night)
    }
}

