//
//  MainMVPViewController.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 24.09.2020.
//

import UIKit

class MainMVPViewController: UIViewController {
    

    @IBOutlet private weak var cityLable: UILabel!
    @IBOutlet private weak var weatherStateLable: UILabel!
    @IBOutlet private weak var temperatureLable: UILabel!
    @IBOutlet private weak var dailyWeatherTable: UITableView!
    
    var presenter: MainViewPresenterProtocol!
    var weekdayss = WeekDayFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showSpinner()
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        cell.renderCell(presenter: presenter, indexPath: indexPath)
        return cell
    }
}

extension MainMVPViewController: MainViewProtocol {
    func success() {
        dailyWeatherTable.reloadData()
        setCurrentWeather()
        self.removeSpinner()
    }
    func failure() {
        print("failure")
        //TODO: Сделать обработку ошибки, когда данные от сервера не получены
    }
}
