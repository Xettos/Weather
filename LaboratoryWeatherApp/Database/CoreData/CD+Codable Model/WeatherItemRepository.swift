//
//  DailyCDRepository.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 06.10.2020.
//

import UIKit
import CoreData

class WeatherItemRepository: Repository {
    
    typealias Y = WeatherItem
    typealias T = DailyWeather
    
    private let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    func fetch() -> [DailyWeather] {
        let request: NSFetchRequest<DailyWeather> = DailyWeather.fetchRequest()
        let sort = NSSortDescriptor(key: "date", ascending: true)
        request.sortDescriptors = [sort]
        do {
            return try persistentContainer.viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func save(instance: WeatherItem?) {
        let context = persistentContainer.newBackgroundContext()
        context.perform {
            var weather = WeatherItem(context: context)
            weather = instance ?? WeatherItem()
            do {
                try context.save()
            } catch {
                print("failed to save to background context")
            }
        }
    }
    
    func delete() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DailyWeather")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try persistentContainer.viewContext.execute(batchDeleteRequest)
        } catch {
            print("failed to delete data from coredata")
        }
    }
}

