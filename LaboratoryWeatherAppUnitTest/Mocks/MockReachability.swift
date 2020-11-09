//
//  MockReachability.swift
//  LaboratoryWeatherAppUnitTest
//
//  Created by Иван Гришечко on 05.11.2020.
//

import XCTest
@testable import LaboratoryWeatherApp

class MockNetworkReachabilityProtocol: NetworkReachabilityProtocol {
    var isReachable = false
}
