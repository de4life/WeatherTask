//
//  WeatherAPI.swift
//  WeatherTask
//
//  Created by Артур Агеев on 02.06.2023.
//

import Foundation
import CoreLocation

class WeatherManager {
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\("d6290e2999f646296d47d36e083c24e4")&units=metric") else { fatalError("Missing URL")}
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error featching weather data") }
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
        
    }
}

struct ResponseBody: Decodable {
    var coord: CoordinatesReponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    
    struct CoordinatesReponse: Decodable {
        var lon: Double
        var lat: Double
    }
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var descriptions: String
    }
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidyty: Double
    }
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}
