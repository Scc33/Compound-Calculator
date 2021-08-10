//
//  ContentView.swift
//  Weather
//
//  Created by Sean Coughlin on 8/7/21.
//

//https://www.youtube.com/watch?v=DxYAhXLtAB0

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.cityName)
                .font(.largeTitle)
                .padding()
            Text(viewModel.temperature)
            Text(viewModel.description)
        }.onAppear(perform: viewModel.refresh)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}
