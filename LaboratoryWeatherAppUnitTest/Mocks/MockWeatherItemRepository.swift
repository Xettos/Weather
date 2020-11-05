//
//  MockWeatherItemRepository.swift
//  LaboratoryWeatherAppUnitTest
//
//  Created by Иван Гришечко on 05.11.2020.
//

import XCTest
@testable import LaboratoryWeatherApp

class MockWeatherItemRepository: WeatherItemRepository {
    var savingCompleted = false
    var fetchingCompleted = false
    var deletingCompleted = false
    
    override func save() {
        savingCompleted = true
    }
    
    override func fetch() -> [DailyWeather] {
        fetchingCompleted = true
        return []
    }
    
    override func delete() {
        deletingCompleted = true
    }
}
