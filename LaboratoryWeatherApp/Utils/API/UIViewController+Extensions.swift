//
//  ActivityIndicator.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 29.09.2020.
//
import UIKit

extension UIViewController {
    var spinnerTag: Int { return 999 }
    
    func showSpinner() {
        guard view.viewWithTag(spinnerTag) == nil else {
            return
        }
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.tag = spinnerTag
        spinner.center = view.center
        spinner.startAnimating()
        view.addSubview(spinner)
    }
    
    func removeSpinner() {
        guard let spinner = view.viewWithTag(spinnerTag) else { return }
            spinner.removeFromSuperview()
    }
}
