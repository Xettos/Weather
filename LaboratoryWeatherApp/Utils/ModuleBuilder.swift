//
//  ModuleBuilder.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 24.09.2020.
//

import UIKit
import Foundation

protocol Builder {
    static func createMainModule() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let view = MainMVPViewController()
        let weatherNetwork = WeatherNetwork()
        let presenter = MainPresenter(view: view, weatherNetwork: weatherNetwork)
        view.presenter = presenter
        return view
    }
}
