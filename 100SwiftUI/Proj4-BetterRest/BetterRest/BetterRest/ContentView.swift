//
//  ContentView.swift
//  BetterRest
//
//  Created by Sean Coughlin on 7/20/21.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var teaAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    func calculateBedtime() {
        //StackOverflow said to use - configuration: MLModelConfiguration() - but didn't work for some reason
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60 * 60
        let totalTime = hour + minute
        
        do {
            let prediction = try
                model.prediction(wake: Double(totalTime), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal sleep time is..."
        } catch {
            // something went wrong
            alertTitle = "Error"
            alertMessage = "Sorry, there was some problem calculating bedtime"
        }
        showingAlert = true
    }
    
    //Needs to be static
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Test")) {
                    //Reminder: ForEach is a view struct
                    ForEach((1...2).reversed(), id: \.self) {
                            Text("\($0)…")
                        }
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    Stepper(value: $coffeeAmount, in: 0...20) {
                        if coffeeAmount == 1 {
                            Text("1 cup")
                        } else {
                            Text("\(coffeeAmount) cups")
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Picker("Tea", selection: $teaAmount) {
                        ForEach((1...5), id: \.self) {
                            Text("\($0)")
                        }
                    }.font(.headline)
                }
                
                Text(alertMessage).font(.headline)
            }
            .navigationBarTitle("BetterRest")
            .navigationBarItems(trailing:
                                    Button(action: calculateBedtime) {
                                        Text("Calculate")
                                    }
            )
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK")))
            }
        }
        /*What the button cares about is that its action is some sort of function that accepts no parameters and sends nothing back – it doesn’t care whether that’s a method or a closure, as long as they both follow those rules.*/
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
