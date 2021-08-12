//
//  ContentView.swift
//  iExpense
//
//  Created by Sean Coughlin on 7/27/21.
//

import SwiftUI

// Now we will need @ObservedObject instead of @State
class User: ObservableObject {
    //@Published is one half of the puzzle, it sents out a message
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct ContentView: View {
    //@ObservedObject is the other half, it watches for changes
    @ObservedObject var user = User()
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName).")
            
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
            Button("Show Sheet") {
                self.showingSheet.toggle()
            }.sheet(isPresented: $showingSheet) {
                SecondView(firstName: user.firstName)
            }
        }
    }
}

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode
    var firstName: String
    
    var body: some View {
        Text("Second View")
        Text("\(firstName)")
        Button("Dismiss") {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
