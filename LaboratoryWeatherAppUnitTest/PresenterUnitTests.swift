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
    var reachabilityManager: MockNetworkReachabilityManager!

    override func setUpWithError() throws {
        view = MockMainViewProtocol()
        mockWeatherNetwork = WeatherNetwork()
        repository = MockWeatherItemRepository()
        presenter = MainPresenter(view: view, weatherNetwork: mockWeatherNetwork, repository: repository)
        reachabilityManager = MockNetworkReachabilityManager()
    }

    override func tearDownWithError() throws {
        presenter = nil
        view = nil
        mockWeatherNetwork = nil
        repository = nil
    }
    
    func testSavingToDB() {
        presenter.saveWeatherInCD()
        
        XCTAssertTrue(repository.savingCompleted)
    }
    
    func testUpdateDB() {
        presenter.saveWeatherInCD()
        
        XCTAssertTrue(repository.savingCompleted)
    }
    
    func testGetUnreachableData() {
        let promise = expectation(description: "unreachable async task ")
        
        MockNetworkReachabilityManager.isReachable { [weak self]_ in
            self?.presenter.repository.fetch()
            promise.fulfill()
        }
        
        MockNetworkReachabilityManager.isUnreachable { [weak self]_ in
            self?.presenter.repository.fetch()
            promise.fulfill()
        }
        waitForExpectations(timeout: 2)
        XCTAssertTrue(repository.fetchingCompleted)
    }
}
