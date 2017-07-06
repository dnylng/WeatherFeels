//
//  ViewController.swift
//  WeatherFeels
//
//  Created by Danny Luong on 7/3/17.
//  Copyright © 2017 dnylng. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var currentTempLbl: UILabel!
    
    @IBOutlet weak var locationLbl: UILabel!
    
    @IBOutlet weak var currentWeatherImg: UIImageView!
    
    @IBOutlet weak var currentWeatherTypeLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Testing if constants are accessible
        print("Current URL: " + CURRENT_WEATHER_URL)
        
        currentWeather = CurrentWeather()
        forecast = Forecast()
        currentWeather.downloadWeatherDetails {
            // Setup UI to download data
            self.updateMainUI()
        }
    }
    
    // Number of columns
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of rows, 6 other days in a week
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    // Create a reusable cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        return cell
    }
    
    // Update the UI w/ the new data
    func updateMainUI() {
        dateLbl.text = currentWeather.date
        currentTempLbl.text = currentWeather.currentTemp
        currentWeatherTypeLbl.text = currentWeather.weatherType
        locationLbl.text = currentWeather.cityName
        currentWeatherImg.image = UIImage(named: currentWeather.weatherType)
    }
    
    // Update the forecast
    func downloadForecastData(comepleted: @escaping DownloadComplete) {
        // Downloading forecast weather data for TableView
        let forecastURL = URL(string: FORECAST_URL)!
        Alamofire.request(forecastURL).responseJSON {
            response in
            let result = response.result
            
            // Access the dictionary of the forecast
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    // For every forecast I find, add it into another dict and put that in an array
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                    }
                }
            }
        }
    }
    
}

