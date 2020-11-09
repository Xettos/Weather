//
//  PresenterUnitTests.swift
//  LaboratoryWeatherAppUnitTest
//
//  Created by Иван Гришечко on 03.11.2020.
//

import XCTest
@testable import LaboratoryWeatherApp

class PresenterUnitTests: XCTestCase {
    
    var presenter: MainPresenter!
    var view: MockMainViewProtocol!
    var mockWeatherNetwork: WeatherNetwork!
    var repository: MockWeatherItemRepository!
    var reachability: MockNetworkReachabilityProtocol!
    
    override func setUpWithError() throws {
        view = MockMainViewProtocol()
        mockWeatherNetwork = WeatherNetwork()
        repository = MockWeatherItemRepository()
        reachability = MockNetworkReachabilityProtocol()
        presenter = MainPresenter(view: view, weatherNetwork: mockWeatherNetwork, repository: repository, reachability: reachability)
    }
    
    override func tearDownWithError() throws {
        presenter = nil
        view = nil
        mockWeatherNetwork = nil
        repository = nil
        reachability = nil
    }
    
    func testSavingToDB() {
        presenter.saveWeatherInCD()
        
        XCTAssertTrue(repository.savingCompleted)
    }
    
    func testUpdateDB() {
        presenter.saveWeatherInCD()
        
        XCTAssertTrue(repository.savingCompleted)
    }
    
    func testSetWeatherWithoutReachability() {
        reachability.isReachable = false
        
        presenter.setCurrentWeather(view: view)
        
        XCTAssertTrue(view.updatedLabels, "Weather is set")
    }
}
