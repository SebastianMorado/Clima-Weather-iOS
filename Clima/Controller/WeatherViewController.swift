//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        print(searchTextField.text!)
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchTextField.text!)
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //use searchtextfield to get weather
        if let city = textField.text {
            weatherManager.fetchWeather(city)
        }
        searchTextField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something here"
            return false
        }
    }
    
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempString
            self.conditionImageView.image = UIImage.init(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
        
    }
    func didFailWithError(error: Error?) {
        print(error!)
    }
    
}
