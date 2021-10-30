//
//  ContentView.swift
//  iExpense
//
//  Created by Sean Coughlin on 7/27/21.
//

/*The first is called UserDefaults, and it allows us to store small amount of user data directly attached to our app. There is no specific number attached to “small”, but you should keep in mind that everything you store in UserDefaults will automatically be loaded when your app launches – if you store a lot in there your app launch will slow down. To give you at least an idea, you should aim to store no more than 512KB in there.*/

import SwiftUI

// Now we will need @ObservedObject instead of @State
class User: ObservableObject {
    //@Published is one half of the puzzle, it sents out a message
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct UserC: Codable {
    var firstName: String
    var lastName: String
}

struct ContentView: View {
    //@ObservedObject is the other half, it watches for changes
    @ObservedObject var user = User()
    @State private var userC = UserC(firstName: "Taylor", lastName: "Swift")

    @State private var showingSheet = false
    
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")

    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Tap count: \(tapCount)") {
                    self.tapCount += 1
                    UserDefaults.standard.set(self.tapCount, forKey: "Tap")
                }
                
                Text("Your name is \(user.firstName) \(user.lastName).")
                
                TextField("First name", text: $user.firstName)
                TextField("Last name", text: $user.lastName)
                Button("Show Sheet") {
                    self.showingSheet.toggle()
                }.sheet(isPresented: $showingSheet) {
                    SecondView(firstName: user.firstName)
                }
                Button("Save User") {
                    let encoder = JSONEncoder()

                    if let data = try? encoder.encode(self.userC) {
                        UserDefaults.standard.set(data, forKey: "UserData")
                    }
                }
                
                List {
                    ForEach(numbers, id: \.self) {
                        Text("\($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button("Add Number") {
                    self.numbers.append(self.currentNumber)
                    self.currentNumber += 1
                }
            }
            .navigationBarItems(leading: EditButton())
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
