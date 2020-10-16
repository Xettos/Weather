//
//  DailyCDRepository.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 06.10.2020.
//

import UIKit
import CoreData

class WeatherItemRepository {
    
    static let shared = WeatherItemRepository()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchWeather() -> [DailyWeather] {
        let request: NSFetchRequest<DailyWeather> = DailyWeather.fetchRequest()
        let sort = NSSortDescriptor(key: "date", ascending: true)
        request.sortDescriptors = [sort]
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    func saveWeather(weatherInstance: WeatherItem?) {
        var weather = WeatherItem(context: self.context)
        weather = weatherInstance ?? WeatherItem()
        do {
            try self.context.save()
        } catch {
            print("failed to save data to coredata")
        }
    }
    
    func delete() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DailyWeather")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(batchDeleteRequest)
        } catch {
            print("failed to delete data from coredata")
        }
    }
}

