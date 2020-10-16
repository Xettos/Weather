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
    
    func renderCell(presenter: MainViewPresenterProtocol, indexPath: IndexPath) {
        var dailyForecast = (presenter.weatherInstance?.daily?.allObjects as? [DailyWeather])?.sorted(by: { $0.date < $1.date})
        var weatherDaysDb = presenter.weatherDB
        
        dailyForecast?.removeFirst()
        weatherDaysDb?.removeFirst()
        
        let dayTemperatureCD = weatherDaysDb?[indexPath.row].temperature?.day
        let nightTemperatureCD = weatherDaysDb?[indexPath.row].temperature?.night
        guard let weekDayCD = weatherDaysDb?[indexPath.row].date else { return }
        let weekDaytextCD = formatter.unixToWeekday(dateStr: "\(weekDayCD)")
        
        let dayTemperature = dailyForecast?[indexPath.row].temperature?.day
        let nightTemperature = dailyForecast?[indexPath.row].temperature?.night
        let weekDay = dailyForecast?[indexPath.row].date
        let weekDaytext = formatter.unixToWeekday(dateStr: "\(weekDay ?? 1)")
        let weatherIcons = (dailyForecast?[indexPath.row].weatherElement?.allObjects as? [WeatherElements])?.first?.iconId
        
        NetworkReachabilityManager.isReachable { [weak self] _ in
            self?.dayTemperature.text = "\(Int(dayTemperature ?? 99))"
            self?.nightTeperature.text = "\(Int(nightTemperature ?? 99))"
            self?.day.text = weekDaytext
            downloader.getWeatherIcon(icon: weatherIcons ?? "10d") { image in
                DispatchQueue.main.async {
                    self?.weatherStateIcon.image = image
                }
            }
        }
        
        NetworkReachabilityManager.isUnreachable { [weak self] _ in
            self?.dayTemperature.text = "\(Int(dayTemperatureCD ?? 99))"
            self?.nightTeperature.text = "\(Int(nightTemperatureCD ?? 99))"
            self?.day.text = weekDaytextCD
            downloader.getWeatherIcon(icon: weatherIcons ?? "10d") { image in
                DispatchQueue.main.async {
                    self?.weatherStateIcon.image = image
                }
            }
        }
    }
}
