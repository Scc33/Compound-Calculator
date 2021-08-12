//
//  ContentView.swift
//  iExpense
//
//  Created by Sean Coughlin on 7/27/21.
//

import SwiftUI

// Now we will need @ObservedObject instead of @State
class User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct ContentView: View {
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
