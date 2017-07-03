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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
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
    
}

