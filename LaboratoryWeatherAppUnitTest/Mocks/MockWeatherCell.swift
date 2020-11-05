//
//  MockWeatherCell.swift
//  LaboratoryWeatherAppUnitTest
//
//  Created by Иван Гришечко on 05.11.2020.
//

import XCTest
import CoreData
@testable import LaboratoryWeatherApp

class MockCell: WeatherCell {
    override func renderCell(fetchedResultsController: NSFetchedResultsController<DailyWeather>, indexPath: IndexPath) {
    }
}
