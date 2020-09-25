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
    
    var presenter: MainViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dailyWeatherTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        setCurrentWeather()
    }
    
    func setCurrentWeather() {
        self.cityLable.text = cities[0].name
        self.weatherStateLable.text = presenter.weatherInstance?.daily.first?.weather.first?.main
        self.temperatureLable.text = "\(presenter.weatherInstance?.daily.first?.temp.day ?? 99)"
    }
}

extension MainMVPViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.weatherInstance?.daily.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let weather = presenter.weatherInstance?.daily[indexPath.row].temp.day
        
        cell.textLabel?.text = "\(Int(weather ?? 99))"
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
    }
}
