//
//  WeatherService.swift
//  Weather
//
//  Created by Sean Coughlin on 8/7/21.
//

import CoreLocation
import Foundation

public final class WeatherService: NSObject {
    private let locationManager = CLLocationManager()
    private let API_KEY = "c2314ea3b69b08101dba1a7bd0ab32e9"
    private var completionHandler: (() -> Void)?
}

struct APIResponse {
    let name: String
    let main: APIMain
    let weather: [APIWeather]
}

struct APIMain: Decodable {
    let temp: Double
}

struct APIWeather: Decodable {
    let description: String
    let iconName: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case iconName = "main"
    }
}
