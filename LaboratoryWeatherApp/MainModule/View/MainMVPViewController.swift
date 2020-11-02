//
//  MainMVPViewController.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 24.09.2020.
//
import UIKit
import CoreData

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
        
        presenter.fetchResultcontroller?.delegate = self
        let cellNib = UINib(nibName: "WeatherCell", bundle: nil)
        dailyWeatherTable.register(cellNib, forCellReuseIdentifier: "WeatherCell")
        presenter.setCurrentWeather(cityLable: cityLable,
                                    weatherLable: weatherStateLable,
                                    temperatureLabel: temperatureLable)
        dailyWeatherTable.refreshControl = refreshControl
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        presenter.gettingData()
        dailyWeatherTable.reloadData()
        sender.endRefreshing()
    }
}

extension MainMVPViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.fetchResultcontroller?.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        cell.renderCell(fetchedResultsController: self.presenter.fetchResultcontroller ?? NSFetchedResultsController(), indexPath: indexPath)
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
        presenter.setCurrentWeather(cityLable: cityLable, weatherLable: weatherStateLable, temperatureLabel: temperatureLable)
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

extension MainMVPViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        dailyWeatherTable.reloadData()
    }
}
