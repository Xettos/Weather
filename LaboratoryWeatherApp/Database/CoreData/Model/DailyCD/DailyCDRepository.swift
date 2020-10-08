//
//  DailyCDRepository.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 06.10.2020.
//

import UIKit
import CoreData

class DailyCDRepository {
    
    static let shared = DailyCDRepository()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchWeather() -> [DailyCD] {
        let request: NSFetchRequest<DailyCD> = DailyCD.fetchRequest()
        let sort = NSSortDescriptor(key: "dt", ascending: true)
        request.sortDescriptors = [sort]
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    func saveWeather(weatherInstance: Weather?) {
        weatherInstance?.daily.forEach({ (daily) in
            let newDailyWeather = DailyCD(context: self.context)
            newDailyWeather.dt = Double(daily.dt)
            newDailyWeather.dayTemp = daily.temp.day
            newDailyWeather.nightTemp = daily.temp.night
            newDailyWeather.weatherState = weatherInstance?.daily.first?.weather.first?.main ?? ""
        })
        do {
            try self.context.save()
        } catch {
            print("failed to save data to coredata")
        }
    }
    
    func delete() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DailyCD")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(batchDeleteRequest)
        } catch {
            print("failed to delete data from coredata")
        }
    }
}

