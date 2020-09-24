//
//  MainPresenter.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 24.09.2020.
//

import Foundation

protocol MainViewProtocol: class {
    func weatherRequest()
    func showWeather(weatherTemp: String)
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, weather: Weather)
    func weatherRequest()
    func showWeather()
}

class MainPresenter: MainViewPresenterProtocol {
//    var weatherNetwork = WeatherNetwork.shared
//    var weatherInstance: Weather?
//    var weatherDaysArray: [Daily]?
//    var weatherElements: [WeatherElement]?
    
    func weatherRequest() {
//        weatherNetwork.getWeather(latitude: Double, longitude: Double) { (weather) in
//                guard let weather = weather else { return }
//                self.weatherInstance = weather
//                self.weatherDaysArray = weather.daily
//                self.showWeather()
    }
    
    let view: MainViewProtocol
    let weather: Weather
    
    required init(view: MainViewProtocol, weather: Weather) {
        self.view = view
        self.weather = weather
    }
    
    func showWeather() {
        let weatherTemp = "\(Int(self.weather.daily.first?.temp.day ?? 99))" + "°C"
        self.view.showWeather(weatherTemp: weatherTemp)
    }
}
