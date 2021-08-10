//
//  WeatherApp.swift
//  Weather
//
//  Created by Sean Coughlin on 8/7/21.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            let weatherSerive = WeatherService()
            let viewModel = WeatherViewModel(weatherService: weatherSerive)
            WeatherView(viewModel: viewModel)
        }
    }
}
