//
//  MockNetwork.swift
//  LaboratoryWeatherAppUnitTest
//
//  Created by Иван Гришечко on 05.11.2020.
//

import XCTest
@testable import LaboratoryWeatherApp

class MockWeatherNetworkProtocol: WeatherNetworkProtocol {
    var callCompleted = false
    
    func getWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherItem, Error>) -> Void) {
        callCompleted = true
    }
}

