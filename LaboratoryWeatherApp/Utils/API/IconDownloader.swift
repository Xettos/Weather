//
//  IconDownloader.swift
//  LaboratoryWeatherApp
//
//  Created by Иван Гришечко on 25.09.2020.
//

import Foundation
import UIKit


class IconDownloader {
    
    func getWeatherIcon(icon id: String, completion: @escaping (_ image: UIImage?) -> Void)  {
        let iconPictureUrl = URL(string: "http://openweathermap.org/img/wn/" + id + "@2x.png")!
        let session = URLSession(configuration: .default)
        let downloadPicTask = session.dataTask(with: iconPictureUrl) { (data, response, error) in
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                if let res = response as? HTTPURLResponse {
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        return completion(image)
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        downloadPicTask.resume()
    }
}

let downloader = IconDownloader()
