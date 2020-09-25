//
//  ViewController.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 22.09.2020.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var cityLable: UILabel!
    @IBOutlet weak var weatherStateLable: UILabel!
    @IBOutlet weak var temperatureLable: UILabel!
    @IBOutlet weak var weatherWeeks: UITableView!
    
    let spbLat = 59.937500
    let spbLon = 30.308611
    var weatherNetwork = WeatherNetwork.shared
    var weatherInstance: Weather?
    var weatherDaysArray: [Daily]?
    var weatherElements: [WeatherElement]?
    let queue = DispatchQueue.global()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.weatherRequest()
        self.showWeather()
    }
    
    func weatherRequest() {
            weatherNetwork.getWeather(latitude: spbLat, longitude: spbLon) { (weather) in
                guard let weather = weather else { return }
                self.weatherInstance = weather
                self.weatherDaysArray = weather.daily
                self.showWeather()
        }
    }
    
    func showWeather() {
        DispatchQueue.main.async {
            self.temperatureLable.text = "\(Int(self.weatherDaysArray?.first?.temp.day ?? 99))" + "°C"
            self.weatherStateLable.text = self.weatherDaysArray?.first?.weather.first?.main
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDaysArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? WeatherDayCell else {
            print("error")
            return UITableViewCell()
        }
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
}
