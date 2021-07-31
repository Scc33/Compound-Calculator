//
//  ContentView.swift
//  Edutainment
//
//  Created by Sean Coughlin on 7/25/21.
//

import SwiftUI

struct ContentView: View {
    @State private var numQuestions = 5
    @State private var multSize = 5
    let step = 5
    let range = 1...15
    
    var body: some View {
        NavigationView {
            VStack {
                Stepper(value: $numQuestions, in: range, step: step) {
                    Text("Current: \(numQuestions) in \(range.description)")
                }
                .padding(10)
                Stepper(value: $multSize, in: range) {
                    Text("Current: \(multSize) in \(range.description) ")
                }
                .padding(10)
                Text("")
                Spacer()
            }
            .navigationTitle(Text("EduApp"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
