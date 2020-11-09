//
//  Mocks.swift
//  LaboratoryWeatherAppUnitTest
//
//  Created by Иван Гришечко on 05.11.2020.
//

import XCTest
@testable import LaboratoryWeatherApp

class MockMainViewProtocol: MainViewProtocol {
        
    var spinnerIsShown = false
    var spinnerIsRemoved = false
    var succeed = false
    var failured = false
    var updatedLabels = false
    
    func showSpinnerView() {
        spinnerIsShown = true
    }
    
    func removeSpinnerView() {
        spinnerIsRemoved = true
    }
    
    func success() {
        succeed = true
    }
    
    func failure(error: Error) {
        failured = true
    }
    
    func updateLables(weather: [DailyWeather]) {
        updatedLabels = true
    }
}
