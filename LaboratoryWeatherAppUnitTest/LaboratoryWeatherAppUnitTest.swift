//
//  LaboratoryWeatherAppUnitTest.swift
//  LaboratoryWeatherAppUnitTest
//
//  Created by Иван Гришечко on 26.10.2020.
//

import XCTest
import CoreData
@testable import LaboratoryWeatherApp

class MockView: MainViewProtocol {
    
    func showSpinnerView() {
        print("show spinner")
    }
    
    func removeSpinnerView() {
        print("remove spinner")
        
    }
    
    func success() {
        print("success")
    }
    
    func failure(error: Error) {
        print("failure")
        
    }
}

class MockNetwork: WeatherNetworkProtocol {
    var networkCall = false
    
    func getWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherItem, Error>) -> Void) {
        networkCall = true
    }
}

class MockRepository: WeatherItemRepository {
    var savingCompleted = false
    var fetchingCompleted = false
    var deletingCompleted = false
    
    override func save() {
        savingCompleted = true
    }
    
    override func fetch() -> [DailyWeather] {
        fetchingCompleted = true
        return []
    }
    
    override func delete() {
        deletingCompleted = true
    }
}

class MockCell: WeatherCell {
    override func renderCell(fetchedResultsController: NSFetchedResultsController<DailyWeather>, indexPath: IndexPath) {
    }
}


class LaboratoryWeatherAppTests: XCTestCase {
    
    var view: MockView!
    var presenter: MainPresenter!
    var weatherNetwork: MockNetwork!
    var repository: MockRepository!
    var mockCell: MockCell!
    var formatter: WeekDayFormatter!
    var sessionUnderTest: URLSession!
    
    override func setUpWithError() throws {
        super.setUp()
        view = MockView()
        weatherNetwork = MockNetwork()
        repository = MockRepository()
        mockCell = MockCell()
        presenter = MainPresenter(view: view, weatherNetwork: weatherNetwork, repository: repository)
        formatter = WeekDayFormatter()
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        view = nil
        presenter = nil
        repository = nil
        weatherNetwork = nil
        mockCell = nil
        sessionUnderTest = nil
    }
    
    func testModuleNotNil() {
        XCTAssertNotNil(view, "view is not nil")
        XCTAssertNotNil(presenter, "presenter is not nil")
        XCTAssertNotNil(repository, "repository is not nil")
        XCTAssertNotNil(weatherNetwork, "weatherNetwork is not nil")
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
    
    func testURLrequest() {
        let lat = 59.937500
        let lon = 30.308611
        let net = WeatherNetwork()
        let promise = expectation(description: "Async network call")
        
        net.getWeather(latitude: lat, longitude: lon) { result in
            switch result {
            case .success(_):
                promise.fulfill()
            case.failure(let error):
                promise.fulfill()
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 2)
        
        XCTAssertTrue(weatherNetwork.networkCall, "call completed")
    }
    
    func testSavingToDB() {
        let mockRepo = MockRepository()
        let pres = MainPresenter(view: view, weatherNetwork: weatherNetwork, repository: mockRepo)
        
        pres.saveWeatherInCD()
        
        XCTAssertTrue(mockRepo.savingCompleted)
    }
    
    func testUpdateDB() {
        let mockRepo = MockRepository()
        let pres = MainPresenter(view: view, weatherNetwork: weatherNetwork, repository: mockRepo)
        
        pres.getFetchController()
        pres.saveWeatherInCD()
        
        XCTAssertTrue(mockRepo.savingCompleted)
    }
}

