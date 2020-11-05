//
//  PresenterUnitTests.swift
//  LaboratoryWeatherAppUnitTest
//
//  Created by Иван Гришечко on 03.11.2020.
//

import XCTest
@testable import LaboratoryWeatherApp

class MockViewProtocol1: MainViewProtocol {
    var spinnerIsShown = false
    var spinnerIsRemoved = false
    var succeed = false
    var failured = false
    
    func showSpinnerView() {
        spinnerIsShown = true
    }
    
    func removeSpinnerView() {
        spinnerIsRemoved = true
    }
    
    func success() {
        succeed = true
    }
    
    func failure(error: Error) {
        failured = true
    }
}

class MockWeatherNetwork: WeatherNetworkProtocol {
    var callCompleted = false
    
    func getWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherItem, Error>) -> Void) {
        callCompleted = true
    }
}

class PresenterUnitTests: XCTestCase {

    var presenter: MainPresenter!
    var view: MockViewProtocol1!
    var mockWeatherNetwork: WeatherNetwork!
    var repository: WeatherItemRepository!

    override func setUpWithError() throws {
        view = MockViewProtocol1()
        mockWeatherNetwork = WeatherNetwork()
        repository = WeatherItemRepository()
        presenter = MainPresenter(view: view, weatherNetwork: mockWeatherNetwork, repository: repository)
    }

    override func tearDownWithError() throws {
        presenter = nil
        view = nil
        mockWeatherNetwork = nil
        repository = nil
    }

    func testSpinner() throws {
        presenter.view?.showSpinnerView()
        presenter.view?.removeSpinnerView()
        
        XCTAssertTrue(self.view.spinnerIsShown)
        XCTAssertTrue(self.view.spinnerIsRemoved)
    }
    
    func testSuccess() {
        presenter.view?.success()
        
        XCTAssertTrue(self.view.succeed)
    }
    
    func testFailure() {
        struct ErrorForTest: Error {
        }
        
        presenter.view?.failure(error: ErrorForTest() as Error)
    
        XCTAssertTrue(self.view.failured)
    }
}
