//Clima

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=9adacca9966f81cd1a557927f4434567&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    // 사용자가 도시명을 검색하면 띄워주는 정보
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    // 사용자의 현 위치 정보를 받아와서 띄워주는 정보
    func fetchWeather(longitude: CLLocationDegrees, latitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lon=\(longitude)&lat=\(latitude)"
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlStirng: String) {
        //creat a URL
        if let url = URL(string: urlStirng) {
            //creat a URL session
            let session = URLSession(configuration: .default)
            //give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //start the task
            task.resume()  
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        }
        catch {
            print(error)
            return nil
        }
    }
}

