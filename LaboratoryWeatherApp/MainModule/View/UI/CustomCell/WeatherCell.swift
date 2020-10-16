//
//  WeatherCell.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 25.09.2020.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    private var presenter: MainViewPresenterProtocol!
    
    @IBOutlet private weak var dayTemperature: UILabel!
    @IBOutlet private weak var nightTeperature: UILabel!
    @IBOutlet private weak var weatherStateIcon: UIImageView!
    @IBOutlet private weak var day: UILabel!
    
    func renderCell(instance: DailyWeather) {
        
        let dayTemperature = instance.temperature?.day
        let nightTemperature = instance.temperature?.night
        let weekDay = instance.date
        let weekDaytext = formatter.unixToWeekday(dateStr: "\(weekDay ?? 1)")
        let weatherIcons = (instance.weatherElement?.allObjects as? [WeatherElements])?.first?.iconId
        
        self.dayTemperature.text = "\(Int(dayTemperature ?? 99))"
        self.nightTeperature.text = "\(Int(nightTemperature ?? 99))"
        self.day.text = weekDaytext
        downloader.getWeatherIcon(icon: weatherIcons ?? "10d") { image in
            DispatchQueue.main.async {
                self.weatherStateIcon.image = image
            }
        }
    }
}
