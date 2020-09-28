//
//  MainMVPViewController.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 24.09.2020.
//

import UIKit

class MainMVPViewController: UIViewController {
    

    @IBOutlet weak var cityLable: UILabel!
    @IBOutlet weak var weatherStateLable: UILabel!
    @IBOutlet weak var temperatureLable: UILabel!
    @IBOutlet weak var dailyWeatherTable: UITableView!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    var presenter: MainViewPresenterProtocol!
    var weekdayss = WeekDayFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "WeatherCell", bundle: nil)
        dailyWeatherTable.register(cellNib, forCellReuseIdentifier: "WeatherCell")
        setCurrentWeather()
    }
    
    func setCurrentWeather() {
        self.cityLable.text = cities[0].name
        self.weatherStateLable.text = presenter.weatherInstance?.daily.first?.weather.first?.main
        self.temperatureLable.text = "\(Int(presenter.weatherInstance?.daily.first?.temp.day ?? 99))" + "°C"
        //TODO: Сделать, чтобы отображалась текущая температура
    }
}

extension MainMVPViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfDays = presenter.weatherInstance?.daily
        numberOfDays?.remove(at: 0)
        return numberOfDays?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var dailyForecast = presenter.weatherInstance?.daily
        dailyForecast?.remove(at: 0)
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        let dayTemp = dailyForecast?[indexPath.row].temp.max
        let nightTemp = dailyForecast?[indexPath.row].temp.night
        let weekDay = dailyForecast?[indexPath.row].dt ?? 0
        let weekDaytext = formatter.unixToWeekday(dateStr: "\(weekDay)")
        let weatherIcons = dailyForecast?[indexPath.row].weather.first?.icon
        
        
        
        cell.dayTemperature.text = "\(Int(dayTemp ?? 99))"
        cell.nightTeperature.text = "\(Int(nightTemp ?? 99))"
        cell.day.text = weekDaytext
        downloader.getWeatherIcon(icon: weatherIcons ?? "10d") { image in
            DispatchQueue.main.async {
                cell.weatherStateIcon.image = image
            }
        }
        
        return cell
    }
}

extension MainMVPViewController: MainViewProtocol {
    func success() {
        dailyWeatherTable.reloadData()
        setCurrentWeather()
    }
    func failure() {
        print("failure")
        //TODO: Сделать обработку ошибки, когда данные от сервера не получены
    }
}
