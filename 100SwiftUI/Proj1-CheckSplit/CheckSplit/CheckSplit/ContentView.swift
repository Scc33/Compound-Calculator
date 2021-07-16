//
//  ContentView.swift
//  CheckSplit
//
//  Created by Sean Coughlin on 7/15/21.
//

import SwiftUI

struct ContentView: View {
    //SwiftUI must use strings to store text field values
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
