//
//  ContentView.swift
//  Weather
//
//  Created by Sean Coughlin on 8/7/21.
//

//https://www.youtube.com/watch?v=DxYAhXLtAB0

import SwiftUI

struct WeatherView: View {
    var body: some View {
        VStack {
            Text("Chicago")
                .font(.largeTitle)
                .padding()
            Text("25C")
            Text("")
            Text("")
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
