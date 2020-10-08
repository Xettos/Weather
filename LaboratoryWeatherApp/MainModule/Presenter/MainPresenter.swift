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
    init(view: MainViewProtocol, weatherNetwork: WeatherNetworkProtocol)
    
    func getWeather()
    func saveWeatherInCD()
    var weatherInstance: Weather? { get set }
    var weatherDB: [DailyCD]? { get set }
}

class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    let weatherNetwork: WeatherNetworkProtocol!
    var weatherInstance: Weather?
    var weatherDB: [DailyCD]?
    var citiesArray = cities
    let repository = DailyCDRepository()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    required init(view: MainViewProtocol, weatherNetwork: WeatherNetworkProtocol) {
        self.view = view
        self.weatherNetwork = weatherNetwork
        self.gettingData()
    }
    
    func getWeather() {
        guard let firstCitiesArrayElement = self.citiesArray.first else {
            return
        }
        weatherNetwork.getWeather(latitude: firstCitiesArrayElement.lat,
                                  longitude: firstCitiesArrayElement.lon) { [weak self] result in
            guard let self = self else { return }
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
                self.saveWeatherInCD()
                self.weatherDB = self.repository.fetchWeather()
            }
        }
        DispatchQueue.main.async {
            self.view?.showSpinnerView()
        }
    }
    
    func saveWeatherInCD() {
        if weatherDB?.count == 0 {
            repository.saveWeather(weatherInstance: weatherInstance)
        } else {
            //update
            repository.delete()
            repository.saveWeather(weatherInstance: weatherInstance)
        }
    }
    
    func gettingData() {
        NetworkReachabilityManager.isReachable { [weak self] _ in
            self?.getWeather()
        }
        
        NetworkReachabilityManager.isUnreachable { [weak self] _ in
            self?.weatherDB = self?.repository.fetchWeather()
            DispatchQueue.main.async {
                self?.view?.success()
                self?.view?.removeSpinnerView()
            }
        }
    }
}
