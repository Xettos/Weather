//
//  ViewControllerTests.swift
//  LaboratoryWeatherAppUnitTest
//
//  Created by Иван Гришечко on 02.11.2020.
//

import XCTest
@testable import LaboratoryWeatherApp

class MockWeatherNetworkProtocol: WeatherNetworkProtocol {
    func getWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherItem, Error>) -> Void) {
    }
}

class MockMainViewProtocol: MainViewProtocol {
    var spinnerIsShown = 0
    var spinnerIsRemoved = 0
    var succeed = false
    var failured = false
    
    func showSpinnerView() {
        spinnerIsShown += 1
    }
    
    func removeSpinnerView() {
        spinnerIsRemoved += 1
    }
    
    func success() {
        succeed = true
    }
    
    func failure(error: Error) {
        failured = true
    }
}

class MockPresenter: MainPresenter {
    var weatherIsSet = false
    override func setCurrentWeather(cityLable: UILabel, weatherLable: UILabel, temperatureLabel: UILabel) {
        weatherIsSet = true
    }
}

class ViewControllerTests: XCTestCase {
    var presenter: MockPresenter!
    var weatherNetwork: MockWeatherNetworkProtocol!
    var viewController = MainMVPViewController()
    var mockView: MockMainViewProtocol!
    var mockRepository: WeatherItemRepository!
    
    
    override func setUpWithError() throws {
        super.setUp()
        mockView = MockMainViewProtocol()
        weatherNetwork = MockWeatherNetworkProtocol()
        mockRepository = WeatherItemRepository()
        presenter = MockPresenter(view: mockView, weatherNetwork: weatherNetwork, repository: mockRepository)
    }
    
    override func tearDownWithError() throws {
        presenter = nil
        mockView = nil
        weatherNetwork = nil
        mockRepository = nil
    }
    
    func testSetWeather() throws {
        let lable1 = UILabel()
        let lable2 = UILabel()
        let lable3 = UILabel()
        
        presenter.setCurrentWeather(cityLable: lable1, weatherLable: lable2, temperatureLabel: lable3)
        
        XCTAssertTrue(presenter.weatherIsSet, "Weather is set")
    }
}
