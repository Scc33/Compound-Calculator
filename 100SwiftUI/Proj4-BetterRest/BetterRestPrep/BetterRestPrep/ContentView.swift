//
//  ContentView.swift
//  BetterRestPrep
//
//  Created by Sean Coughlin on 7/22/21.
//

import SwiftUI

func DateExample() {
    //Date components allows for building parts at a time
    var comp = DateComponents()
    comp.hour = 8
    comp.minute = 0
    let date = Calendar.current.date(from: comp) ?? Date()
    
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    let dateString = formatter.string(from: Date())

}

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date()
    
    var body: some View {
        VStack {
            Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                //Text("\(sleepAmount, specifier: "%.2f") hours")
                //Use .g to make things clean with .25 increments
                Text("\(sleepAmount, specifier: "%.g") hours")
            }
            //Only dates in the future and with a title
            DatePicker("Please enter a date", selection: $wakeUp, in: Date()...)
            //Only displays hours and minutes
            DatePicker("", selection: $wakeUp, displayedComponents: .hourAndMinute)
            //Pretty display with a form
            Form {
                DatePicker("Please enter a date", selection: $wakeUp)
            }
            DatePicker("Please enter a date", selection: $wakeUp)
                .labelsHidden()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*lol :)
 cal 10 1752
 October 1752
Su Mo Tu We Th Fr Sa
1  2  3  4  5  6  7
8  9 10 11 12 13 14
15 16 17 18 19 20 21
22 23 24 25 26 27 28
29 30 31        */
