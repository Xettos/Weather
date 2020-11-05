//
//  MockPresenter.swift
//  LaboratoryWeatherAppUnitTest
//
//  Created by Иван Гришечко on 05.11.2020.
//

import XCTest
@testable import LaboratoryWeatherApp

class MockMainPresenter: MainPresenter {
    var weatherIsSet = false
    
    override func setCurrentWeather(cityLable: UILabel, weatherLable: UILabel, temperatureLabel: UILabel) {
        weatherIsSet = true
    }
}
