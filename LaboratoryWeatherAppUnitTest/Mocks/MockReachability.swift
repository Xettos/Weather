//
//  MockReachability.swift
//  LaboratoryWeatherAppUnitTest
//
//  Created by Иван Гришечко on 05.11.2020.
//

import XCTest
@testable import LaboratoryWeatherApp

class MockNetworkReachabilityManager: NetworkReachabilityManager {
    static var shared: MockNetworkReachabilityManager = {
        return MockNetworkReachabilityManager()
    }()
}
