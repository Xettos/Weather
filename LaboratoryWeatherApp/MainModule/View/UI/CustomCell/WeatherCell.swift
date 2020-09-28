//
//  WeatherCell.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 25.09.2020.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    private var presenter: MainViewPresenterProtocol!

    @IBOutlet weak var dayTemperature: UILabel!
    @IBOutlet weak var nightTeperature: UILabel!
    @IBOutlet weak var weatherStateIcon: UIImageView!
    @IBOutlet weak var day: UILabel!
    
    func renderCell(presenter: MainViewPresenterProtocol, indexPath: IndexPath) {
        var dailyForecast = presenter.weatherInstance?.daily
        dailyForecast?.remove(at: 0)
        
        let dayTemp = dailyForecast?[indexPath.row].temp.max
        let nightTemp = dailyForecast?[indexPath.row].temp.night
        let weekDay = dailyForecast?[indexPath.row].dt ?? 0
        let weekDaytext = formatter.unixToWeekday(dateStr: "\(weekDay)")
        let weatherIcons = dailyForecast?[indexPath.row].weather.first?.icon
        
        self.dayTemperature.text = "\(Int(dayTemp ?? 99))"
        self.nightTeperature.text = "\(Int(nightTemp ?? 99))"
        self.day.text = weekDaytext
        downloader.getWeatherIcon(icon: weatherIcons ?? "10d") { image in
            DispatchQueue.main.async {
                self.weatherStateIcon.image = image
            }
        }
    }
}
