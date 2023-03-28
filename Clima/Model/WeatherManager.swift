//
//  WeatherManager.swift
//  Clima
//
//  Created by Sebastian Morado on 4/18/21.
//  
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error?)
}


struct WeatherManager {
    let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
    var weatherURL : String {
        return "https://api.openweathermap.org/data/2.5/weather?appid=" + apiKey! + "&units=metric&"
    }
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName : String) {
        let urlString = weatherURL + "q=" + cityName
        performRequest(with: urlString)
    }
    
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let urlString = weatherURL + "lat=" + String(lat) + "&lon=" + String(lon)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            //get specific weather data from JSON
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            return WeatherModel(conditionID: id, cityName: name, temp: temp)
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
}
