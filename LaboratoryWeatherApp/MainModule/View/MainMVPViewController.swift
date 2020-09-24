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
        
        presenter.weatherRequest()
        presenter.showWeather()
    }
}

extension MainMVPViewController: MainViewProtocol {
    func weatherRequest() {
        <#code#>
    }
    
    func showWeather(weatherTemp: String) {
        self.temperatureLable.text = weatherTemp
    }   
}
