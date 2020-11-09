//
//  LaboratoryWeatherAppUnitTest.swift
//  LaboratoryWeatherAppUnitTest
//
//  Created by Иван Гришечко on 26.10.2020.
//

import XCTest
import CoreData
@testable import LaboratoryWeatherApp

class LaboratoryWeatherAppUnitTests: XCTestCase {
    
    var view: MockMainViewProtocol!
    var presenter: MainPresenter!
    var weatherNetwork: MockWeatherNetworkProtocol!
    var repository: MockWeatherItemRepository!
    var mockCell: MockCell!
    var formatter: WeekDayFormatter!
    var reachability: MockNetworkReachabilityProtocol!
    
    override func setUpWithError() throws {
        super.setUp()
        view = MockMainViewProtocol()
        weatherNetwork = MockWeatherNetworkProtocol()
        repository = MockWeatherItemRepository()
        mockCell = MockCell()
        reachability = MockNetworkReachabilityProtocol()
        presenter = MainPresenter(view: view, weatherNetwork: weatherNetwork, repository: repository, reachability: reachability)
        formatter = WeekDayFormatter()
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        view = nil
        presenter = nil
        repository = nil
        weatherNetwork = nil
        mockCell = nil
        formatter = nil
    }
    
    func testModuleNotNil() {
        XCTAssertNotNil(view, "view is not nil")
        XCTAssertNotNil(presenter, "presenter is not nil")
        XCTAssertNotNil(repository, "repository is not nil")
        XCTAssertNotNil(weatherNetwork, "weatherNetwork is not nil")
    }
    
    func testURLrequest() {
        let lat = 59.937500
        let lon = 30.308611
        let net = WeatherNetwork()
        let promise = expectation(description: "Async network call")
        
        net.getWeather(latitude: lat, longitude: lon) { result in
            switch result {
            case .success(_):
                promise.fulfill()
                XCTAssertTrue(true)
            case.failure(let error):
                promise.fulfill()
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 4)
    }
    
    func testWeekdayformatter() {
        let unixWeekdays: [String] = ["1604278800","1604372400","1604451600","1604538000","1604624400","1604714400","1604800800"]
        let stringDays: [String] = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday", "Sunday"]
        var weekdaysFormated: [String] = []
        
        unixWeekdays.forEach { day in
            let dayFormatted = self.formatter.unixToWeekday(dateStr: day)
            weekdaysFormated.append(dayFormatted)
        }
        
        XCTAssertEqual(stringDays, weekdaysFormated)
    }
}

