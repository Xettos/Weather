//
//  LaboratoryWeatherAppTests.swift
//  LaboratoryWeatherAppTests
//
//  Created by Иван Гришечко on 22.09.2020.
//

import XCTest
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

class LaboratoryWeatherAppTests: XCTestCase {
    
    var view: MockView!
    var presenter: MainPresenter!
    var weatherNetwork: WeatherNetworkProtocol!
    var repository: WeatherItemRepository!

    override func setUpWithError() throws {
        view = MockView()
        presenter = MainPresenter(view: view, weatherNetwork: weatherNetwork, repository: repository)
    }

    override func tearDownWithError() throws {
        view = nil
        presenter = nil
    }
    
    func testModuleNotNil() {
        XCTAssertNotNil(view, "view is not nil")
        XCTAssertNotNil(presenter, "presenter is not nil")
    }
}
