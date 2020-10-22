//
//  Repository.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 19.10.2020.
//

import Foundation
import CoreData

protocol Repository {
    associatedtype T: NSManagedObject, Decodable
    
    func fetch() -> [T]
    func save()
    func delete()
}
