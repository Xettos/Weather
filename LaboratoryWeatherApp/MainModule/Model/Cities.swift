//
//  Cities.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 23.09.2020.
//

import Foundation

enum GeographicalCoordinates {
    case latitude(Double)
    case longitude(Double)
}

struct CitiesCoordinates {
    let SaintPetersburg: GeographicalCoordinates
    let Moscow: GeographicalCoordinates
}
