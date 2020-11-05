//
//  ViewControllerTests.swift
//  LaboratoryWeatherAppUnitTest
//
//  Created by Иван Гришечко on 02.11.2020.
//

import XCTest
@testable import LaboratoryWeatherApp


class ViewControllerTests: XCTestCase {
    var presenter: MockMainPresenter!
    var weatherNetwork: MockWeatherNetworkProtocol!
    var viewController = MainMVPViewController()
    var mockView: MockMainViewProtocol!
    var mockRepository: WeatherItemRepository!
    
    
    override func setUpWithError() throws {
        super.setUp()
        mockView = MockMainViewProtocol()
        weatherNetwork = MockWeatherNetworkProtocol()
        mockRepository = WeatherItemRepository()
        presenter = MockMainPresenter(view: mockView, weatherNetwork: weatherNetwork, repository: mockRepository)
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
    
    func testSpinner() throws {
        presenter.view?.showSpinnerView()
        presenter.view?.removeSpinnerView()
        
        XCTAssertTrue(self.mockView.spinnerIsShown)
        XCTAssertTrue(self.mockView.spinnerIsRemoved)
    }
    
    func testSuccess() {
        presenter.view?.success()
        
        XCTAssertTrue(self.mockView.succeed)
    }
    
    func testFailure() {
        struct ErrorForTest: Error {
        }
        
        presenter.view?.failure(error: ErrorForTest() as Error)
        XCTAssertTrue(self.mockView.failured)
    }
}
