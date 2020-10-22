//
//  WeatherCell.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 25.09.2020.
//

import UIKit
import CoreData

class WeatherCell: UITableViewCell {
    
    private var presenter: MainViewPresenterProtocol!
    
    @IBOutlet private weak var dayTemperature: UILabel!
    @IBOutlet private weak var nightTeperature: UILabel!
    @IBOutlet private weak var weatherStateIcon: UIImageView!
    @IBOutlet private weak var day: UILabel!
    
    func renderCell(fetchedResultsController: NSFetchedResultsController<DailyWeather>, indexPath: IndexPath) {
        
        let weather = fetchedResultsController.object(at: indexPath)
        let weekDaytext = formatter.unixToWeekday(dateStr: "\(weather.date)")
        let weatherIcons = (weather.weatherElement?.allObjects as? [WeatherElements])?.first?.iconId
        
        self.dayTemperature.text = "\(Int(weather.temperature?.day ?? 99))"
        self.nightTeperature.text = "\(Int(weather.temperature?.night ?? 99))"
        self.day.text = weekDaytext
        downloader.getWeatherIcon(icon: weatherIcons ?? "10d") { image in
            DispatchQueue.main.async {
                self.weatherStateIcon.image = image
            }
        }
    }
}
