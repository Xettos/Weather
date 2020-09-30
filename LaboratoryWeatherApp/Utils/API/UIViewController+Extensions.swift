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
        spinner.center = self.view.center
        spinner.startAnimating()
        view.addSubview(spinner)
        self.view.addSubview(spinner)
    }
    
    func removeSpinner() {
        if let spinner  = view.viewWithTag(spinnerTag) {
            spinner.removeFromSuperview()
    } else {
        print("Error: this VC doesn't contains view with this tag")
    }
    }
}
