//
//  ActivityIndicator.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 29.09.2020.
//

import UIKit

extension UIViewController {
    var spinnerTag: Int { return 999}
    
    func showSpinner() {
        let aView = UIView(frame: self.view.bounds)
        aView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        if !self.view.subviews.contains(view.viewWithTag(spinnerTag) ?? view) {
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.tag = 11
            spinner.center = aView.center
            spinner.startAnimating()
            aView.addSubview(spinner)
            self.view.addSubview(spinner)
        } else {
            print("Error: this VC already contains view with spinnerTag")
        }
    }
    
    func removeSpinner() {
        if let spinner  = view.viewWithTag(11) {
            spinner.removeFromSuperview()
    } else {
        print("Error: this VC doesn't contains view with this tag")
    }
    }
}
