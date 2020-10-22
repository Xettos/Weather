//
//  MainPresenter.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 24.09.2020.
//

import UIKit
import Foundation
import CoreData

protocol MainViewProtocol: class {
    func showSpinnerView()
    func removeSpinnerView()
    func success()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, weatherNetwork: WeatherNetworkProtocol, repository: WeatherItemRepository)
    
    var weatherInstance: WeatherItem? { get set }
    var weatherDB: [DailyWeather]? { get set }
    var fetchResultcontroller: NSFetchedResultsController<DailyWeather>? { get set }
    
    func gettingData()
    func setCurrentWeather(cityLable: UILabel, weatherLable: UILabel, temperatureLabel: UILabel)
}

class MainPresenter: MainViewPresenterProtocol {
            
    weak var view: MainViewProtocol?
    let weatherNetwork: WeatherNetworkProtocol!
    var weatherInstance: WeatherItem?
    var weatherDB: [DailyWeather]?
    var citiesArray = cities
    let repository: WeatherItemRepository
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchResultcontroller: NSFetchedResultsController<DailyWeather>?

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
            let fetchedObjects = self?.fetchResultcontroller?.fetchedObjects
            cityLable.text = cities[0].name
            weatherLable.text = (fetchedObjects?.first?.weatherElement?.allObjects as? [WeatherElements])?.first?.weatherState
            temperatureLabel.text = "\(Int(fetchedObjects?.first?.temperature?.day ?? 99))" + "°C"
        }
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
                    self.saveWeatherInCD()
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
        if fetchResultcontroller?.fetchedObjects?.count == 0 {
            repository.save()
        } else {
            //update
            repository.delete()
            repository.save()
        }
    }
    
    func gettingData() {
        NetworkReachabilityManager.isReachable { [weak self] _ in
            self?.getWeather()
            self?.getFetchController()
        }
        
        NetworkReachabilityManager.isUnreachable { [weak self] _ in
            self?.getFetchController()
            DispatchQueue.main.async {
                self?.view?.success()
                self?.view?.removeSpinnerView()
            }
        }
    }
    
    func getFetchController() {
        self.fetchResultcontroller = repository.fetchResultcontroller
    }
}
