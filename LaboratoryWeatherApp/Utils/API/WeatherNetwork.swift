//
//  WeatherNetwork.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 22.09.2020.
//
import UIKit
import Foundation

protocol WeatherNetworkProtocol {
    func getWeather(latitude: Double, longitude: Double, completion: @escaping (Result<Weather?, Error>) -> Void)
}

class WeatherNetwork: WeatherNetworkProtocol {
    
    static let shared = WeatherNetwork()
    
    private let apiKey = "b6e1ec5134b38b68d1259d333bf7936d"
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var urlConstructor = URLComponents()
    
    func getWeather(latitude: Double, longitude: Double, completion: @escaping (Result<Weather?, Error>) -> Void) {
        dataTask?.cancel()
        
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.openweathermap.org"
        urlConstructor.path = "/data/2.5/onecall"
        urlConstructor.queryItems = [URLQueryItem(name: "lat", value: "\(latitude)"),
                                     URLQueryItem(name: "lon", value: "\(longitude)"),
                                     URLQueryItem(name: "appid", value: apiKey),
                                     URLQueryItem(name: "units", value: "metric")
        ]
        
        dataTask = defaultSession.dataTask(with: self.urlConstructor.url!, completionHandler: { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else {
                return
            }
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                completion(.success(weather))
            } catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError)")
            }
        })
        dataTask?.resume()
    }
}
