//
//  MainPresenter.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 24.09.2020.
//

import Foundation

protocol MainViewProtocol: class {
    func success()
    func failure()
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, weatherNetwork: WeatherNetworkProtocol)
    
    func getWeather()
    var weatherInstance: Weather? { get set }
}

class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    let weatherNetwork: WeatherNetworkProtocol!
    var weatherInstance: Weather?
    var citiesArray = cities

    required init(view: MainViewProtocol, weatherNetwork: WeatherNetworkProtocol) {
        self.view = view
        self.weatherNetwork = weatherNetwork
        getWeather()
    }
    
    func getWeather() {
        guard let firstCitiesArrayElement = self.citiesArray.first else {
            return
        }
        weatherNetwork.getWeather(latitude: firstCitiesArrayElement.lat,
                                  longitude: firstCitiesArrayElement.lon) { [weak self] (weather) in
            guard let weather = weather else { return }
            DispatchQueue.main.async {
                self?.weatherInstance = weather
                self?.view?.success()
            }
        }
    }
}
