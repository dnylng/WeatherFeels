//
//  ViewController.swift
//  WeatherFeels
//
//  Created by Danny Luong on 7/3/17.
//  Copyright © 2017 dnylng. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var currentTempLbl: UILabel!
    
    @IBOutlet weak var locationLbl: UILabel!
    
    @IBOutlet weak var currentWeatherImg: UIImageView!
    
    @IBOutlet weak var currentWeatherTypeLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var wallpaper: UIImageView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tell the location manager how we want it to work
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationAuthStatus()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        Testing if constants are accessible
//        print("Current URL: " + CURRENT_WEATHER_URL)
        
        currentWeather = CurrentWeather()
        currentWeather.downloadWeatherDetails {
            self.downloadForecastData {
                // Setup UI to download data
                self.updateMainUI()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let rand = arc4random_uniform(3)
        wallpaper.image = UIImage(named: "Wallpaper\(rand)")
    }
    
    // Did the user allow or deny location usage?
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedIntance.latitude = currentLocation.coordinate.latitude
            Location.sharedIntance.longitude = currentLocation.coordinate.longitude
//            print("Current Location: (\(currentLocation.coordinate.latitude), \(currentLocation.coordinate.longitude))")
//            print("Singleton Location: (\(Location.sharedIntance.latitude!), \(Location.sharedIntance.longitude!))")
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    // Number of columns
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of rows, 6 other days in a week
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    // Create a reusable cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
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
    func downloadForecastData(completed: @escaping DownloadComplete) {
        // Downloading forecast weather data for TableView
        Alamofire.request(FORECAST_URL).responseJSON {
            response in
//            print(response)
            let result = response.result
            
            // Access the dictionary of the forecast
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    // For every forecast I find, add it into another dict and put that in an array
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
}

