//
//  DailyCDRepository.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 06.10.2020.
//

import UIKit
import CoreData

class WeatherItemRepository: Repository {
    typealias T = DailyWeather
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
        lazy var fetchResultcontroller: NSFetchedResultsController<DailyWeather> = {
        let fetchRequest = NSFetchRequest<DailyWeather>(entityName: "DailyWeather")
        let sort = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: appDelegate.persistentContainer.viewContext,
                                                    sectionNameKeyPath: nil, cacheName: nil)
        do {
            try controller.performFetch()
        } catch  {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return controller
    }()
    
    func fetch() -> [DailyWeather] {
        let request: NSFetchRequest<DailyWeather> = DailyWeather.fetchRequest()
        let sort = NSSortDescriptor(key: "date", ascending: true)
        request.sortDescriptors = [sort]
        do {
            return try appDelegate.persistentContainer.viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func save() {
        let context = appDelegate.backgroundContext
        context.perform {
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
            try appDelegate.backgroundContext.execute(batchDeleteRequest)
            appDelegate.backgroundContext.reset()
        } catch {
            print("failed to delete data from coredata")
        }
    }
}

