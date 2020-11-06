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
    func updateLables(weather: [DailyWeather])
}

protocol MainViewPresenterProtocol: class {
    var weatherInstance: WeatherItem? { get set }
    var weatherDB: [DailyWeather]? { get set }
    var fetchResultcontroller: NSFetchedResultsController<DailyWeather>? { get set }
    
    func getData()
    func setCurrentWeather(view: MainViewProtocol)
    
    init(view: MainViewProtocol, weatherNetwork: WeatherNetworkProtocol, repository: WeatherItemRepository, reachability: NetworkReachabilityProtocol)
}

class MainPresenter: MainViewPresenterProtocol {

    weak var view: MainViewProtocol?
    let weatherNetwork: WeatherNetworkProtocol!
    let reachability: NetworkReachabilityProtocol!
    let repository: WeatherItemRepository
    var weatherInstance: WeatherItem?
    var weatherDB: [DailyWeather]?
    var citiesArray = cities
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchResultcontroller: NSFetchedResultsController<DailyWeather>?

    
    required init(view: MainViewProtocol, weatherNetwork: WeatherNetworkProtocol, repository: WeatherItemRepository, reachability: NetworkReachabilityProtocol) {
        self.view = view
        self.weatherNetwork = weatherNetwork
        self.repository = repository
        self.reachability = reachability
        self.getData()
    }
    
    func setCurrentWeather(view: MainViewProtocol) {
        
        reachability.isReachable { [weak self] _ in
            guard let weatherArray = (self?.weatherInstance?.daily?.allObjects as? [DailyWeather])?.sorted(by: {$0.date < $1.date}) else { return }
            view.updateLables(weather: weatherArray)
        }
        
        reachability.isUnreachable { [weak self] _ in
            guard let fetchedObjects = self?.fetchResultcontroller?.fetchedObjects else { return }
            view.updateLables(weather: fetchedObjects)
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
                    self.view?.success()
                    self.view?.removeSpinnerView()
                case .failure(let error):
                    self.view?.failure(error: error)
                    self.view?.removeSpinnerView()
                }
                self.saveWeatherInCD()
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
    
    func getData() {
        reachability.isReachable { [weak self] _ in
            self?.getWeather()
            self?.getFetchController()
        }
        
        reachability.isUnreachable { [weak self] _ in
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
