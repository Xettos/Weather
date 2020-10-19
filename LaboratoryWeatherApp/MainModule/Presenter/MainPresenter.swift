//
//  MainPresenter.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 24.09.2020.
//

import UIKit
import Foundation

protocol MainViewProtocol: class {
    func showSpinnerView()
    func removeSpinnerView()
    func success()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, weatherNetwork: WeatherNetworkProtocol, repository: WeatherItemRepository)
    
    func gettingData()
    func setCurrentWeather(cityLable: UILabel, weatherLable: UILabel, temperatureLabel: UILabel)
    var weatherInstance: WeatherItem? { get set }
    var weatherDB: [DailyWeather]? { get set }
}

class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    let weatherNetwork: WeatherNetworkProtocol!
    var weatherInstance: WeatherItem?
    var weatherDB: [DailyWeather]?
    var citiesArray = cities
    let repository: WeatherItemRepository
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    required init(view: MainViewProtocol, weatherNetwork: WeatherNetworkProtocol, repository: WeatherItemRepository) {
        self.view = view
        self.weatherNetwork = weatherNetwork
        self.repository = repository
        self.gettingData()
    }
    
    func setCurrentWeather(cityLable: UILabel, weatherLable: UILabel, temperatureLabel: UILabel) {
        NetworkReachabilityManager.isReachable { [weak self] _ in
            let array = (self?.weatherInstance?.daily?.allObjects as? [DailyWeather])?.sorted(by: {$0.date < $1.date})
            let weatherElements = array?.first?.weatherElement?.allObjects as? [WeatherElements]
            cityLable.text = cities[0].name
            weatherLable.text = weatherElements?.first?.weatherState
            temperatureLabel.text = "\(Int(array?.first?.temperature?.day ?? 99))" + "°C"
        }
        
        NetworkReachabilityManager.isUnreachable { [weak self] _ in
                let arrayDB = self?.weatherDB?.sorted(by: { $0.date < $1.date })
                let weatherElements = arrayDB?.first?.weatherElement?.allObjects as? [WeatherElements]
                cityLable.text = cities[0].name
                weatherLable.text = weatherElements?.first?.weatherState
                temperatureLabel.text = "\(Int(arrayDB?.first?.temperature?.day ?? 99))" + "°C"
        }
    }
    
    func getWeather() {
        guard let firstCitiesArrayElement = self.citiesArray.first else {
            return
        }
        weatherNetwork.getWeather(latitude: firstCitiesArrayElement.lat,
                                  longitude: firstCitiesArrayElement.lon) { [weak self] result in
            guard let self = self else { return }
            self.saveWeatherInCD()
            self.weatherDB = self.repository.fetch()
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self.weatherInstance = weather
                    self.view?.success()
                    self.view?.removeSpinnerView()
                case .failure(let error):
                    self.view?.failure(error: error)
                    self.view?.removeSpinnerView()
                }
            }
        }
        DispatchQueue.main.async {
            self.view?.showSpinnerView()
        }
    }
    
    func saveWeatherInCD() {
        if weatherDB?.count == 0 {
            repository.save(instance: weatherInstance)
        } else {
            //update
            repository.delete()
            repository.save(instance: weatherInstance)
        }
    }
    
    func gettingData() {
        NetworkReachabilityManager.isReachable { [weak self] _ in
            self?.getWeather()
        }
        
        NetworkReachabilityManager.isUnreachable { [weak self] _ in
            self?.weatherDB = self?.repository.fetch()
            DispatchQueue.main.async {
                self?.view?.success()
                self?.view?.removeSpinnerView()
            }
        }
    }
}
