//
//  WeekDayFormatter.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 25.09.2020.
//

import Foundation

struct WeekDayFormatter {

    func unixToWeekday(dateStr: String) -> String {
        let date = Date(timeIntervalSince1970: Double(dateStr)!)
        let dateFormatter = Calendar.current.component(.weekday, from: date)
        switch dateFormatter {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return "Error"
        }
    }
}

let formatter = WeekDayFormatter()

