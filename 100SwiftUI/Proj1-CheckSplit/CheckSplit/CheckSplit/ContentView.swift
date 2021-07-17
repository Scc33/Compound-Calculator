//
//  ContentView.swift
//  CheckSplit
//
//  Created by Sean Coughlin on 7/15/21.
//

import SwiftUI

struct ContentView: View {
    //SwiftUI must use strings to store text field values
    //One of the great things about the @State property wrapper is that it automatically watches for changes, and when something happens it will automatically re-invoke the body property
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var basePerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 0
        let orderAmount = Double(checkAmount) ?? 0 // need to remove the optional
        
        let amountPerPerson = orderAmount / peopleCount

        return amountPerPerson
    }
    
    var tipPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0 // need to remove the optional
        
        let tipValue = orderAmount / 100 * tipSelection
        let amountPerPerson = tipValue / peopleCount

        return amountPerPerson
    }
    
    var totalPerPerson: Double {
        return basePerPerson + tipPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                    /*Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }*/
                }
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            //remember $ is shorthand for closures
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Base Cost")) {
                    Text("$\(basePerPerson, specifier: "%.2f")")
                }
                Section(header: Text("Tip")) {
                    Text("$\(tipPerPerson, specifier: "%.2f")")
                }
                Section(header: Text("Total cost per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
        }
        .navigationBarTitle("CheckSplit")
    }
}

/*What you’re seeing here is the importance of what’s called declarative user interface design. This means we say what we want rather than say how it should be done. We said we wanted a picker with some values inside, but it was down to SwiftUI to decide whether a wheel picker or the sliding view approach is better. It’s choosing the sliding view approach because the picker is inside a form, but on other platforms and environments it could choose something else.*/

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
