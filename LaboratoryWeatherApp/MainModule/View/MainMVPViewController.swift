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
    var weekdays = WeekDayFormatter()
    
    let refreshControl: UIRefreshControl = {
        let myRefreshControl = UIRefreshControl()
        myRefreshControl.addTarget(UITableView(), action: #selector(refresh(sender:)), for: .valueChanged)
        return myRefreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "WeatherCell", bundle: nil)
        dailyWeatherTable.register(cellNib, forCellReuseIdentifier: "WeatherCell")
        setCurrentWeather()
        dailyWeatherTable.refreshControl = refreshControl
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        presenter.getWeather()
        dailyWeatherTable.reloadData()
        sender.endRefreshing()
    }
    
    func setCurrentWeather() {
        
        NetworkReachabilityManager.isReachable { [weak self] _ in
            let array = (self?.presenter.weatherInstance?.daily?.allObjects as? [DailyWeather])?.sorted(by: {$0.date < $1.date})
            let weatherElements = array?.first?.weatherElement?.allObjects as? [WeatherElements]
            self?.cityLable.text = cities[0].name
            self?.weatherStateLable.text = weatherElements?.first?.weatherState
            self?.temperatureLable.text = "\(Int(array?.first?.temperature?.day ?? 99))" + "°C"
        }
        
        NetworkReachabilityManager.isUnreachable { [weak self] _ in
                
                let arrayDB = self?.presenter.weatherDB?.sorted(by: { $0.date < $1.date })
                let weatherElements = arrayDB?.first?.weatherElement?.allObjects as? [WeatherElements]
                self?.cityLable.text = cities[0].name
                self?.weatherStateLable.text = weatherElements?.first?.weatherState
                self?.temperatureLable.text = "\(Int(arrayDB?.first?.temperature?.day ?? 99))" + "°C"
        }
    }
}

extension MainMVPViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (presenter.weatherInstance?.daily?.count ?? 0) - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        cell.renderCell(presenter: presenter, indexPath: indexPath)
        return cell
    }
}

extension MainMVPViewController: MainViewProtocol {
    func showSpinnerView() {
        showSpinner()
    }
    
    func removeSpinnerView() {
        removeSpinner()
    }
    
    func success() {
        dailyWeatherTable.reloadData()
        setCurrentWeather()
    }
    
    func failure(error: Error) {
        print("failed to get weather from server")
    }
}
