//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sean Coughlin on 7/16/21.
//

/*Oprah Winfrey once said, “do what you have to do until you can do what you want to do.”*/

import SwiftUI

struct ContentView: View {
    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            //edgesIgnoringSafeArea allows blue to fill whole screen
            Color.blue.edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer]) .foregroundColor(.white)
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        // flag was tapped
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                        //modifier tells SwiftUI to render the original image pixels rather than trying to recolor them as a button
                    }
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
