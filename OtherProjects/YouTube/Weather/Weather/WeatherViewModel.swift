//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Sean Coughlin on 8/9/21.
//

import Foundation

public class WeatherViewModel: ObservableObject {
    @Published var cityName: String = "City Name"
    @Published var temperature: String = "--"
    @Published var description: String = "Description"
    @Published var weatherIcon: String = "--"
    
    public let weatherService: WeatherService
    
    public init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    public func refresh() {
        weatherService.loadWeatherData { weather in
            DispatchQueue.main.async {
                self.cityName = weather.city
                self.temperature = "\(weather.temperature)C"
                self.description = weather.description.capitalized
                //self.weatherIcon = iconMap[weather.iconName]
            }
        }
    }
}
