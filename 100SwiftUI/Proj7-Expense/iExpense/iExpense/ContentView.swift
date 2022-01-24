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

class Expenses: ObservableObject {
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
    
    @Published var items = [ExpenseItem]()  {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}


struct ContentView: View {
    //@ObservedObject is the other half, it watches for changes
    @ObservedObject var user = User()
    @State private var userC = UserC(firstName: "Taylor", lastName: "Swift")
    @StateObject var expenses = Expenses()
    
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    @State private var showingAddExpense = false
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
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
                Button {
                    self.showingAddExpense.toggle()
                } label: {
                    Image(systemName: "plus")
                }.sheet(isPresented: $showingAddExpense) {
                    // show an AddView here
                    AddView(expenses: Expenses())
                }
                Button("Save User") {
                    let encoder = JSONEncoder()

                    if let data = try? encoder.encode(self.userC) {
                        UserDefaults.standard.set(data, forKey: "UserData")
                    }
                }
                
                List {
                    ForEach(expenses.items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }

                            Spacer()
                            Text(item.amount, format: .currency(code: "USD"))
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                .navigationTitle("iExpense")
                .toolbar {
                    Button {
                        let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                        expenses.items.append(expense)
                    } label: {
                        Image(systemName: "plus")
                    }
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
