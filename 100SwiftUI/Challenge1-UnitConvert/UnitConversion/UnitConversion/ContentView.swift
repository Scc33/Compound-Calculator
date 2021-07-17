//
//  ContentView.swift
//  UnitConversion
//
//  Created by Sean Coughlin on 7/16/21.
//

import SwiftUI

struct ContentView: View {
    @State private var unit = 0
    @State private var val1 = ""
    @State private var val2 = ""
    @State private var type1 = "milliliters"
    @State private var type2 = "milliliters"
    let units = ["temp", "length", "time", "volume"]
    let temp = ["Celsius", "Fahrenheit", "Kelvin"]
    let length = ["meters", "kilometers", "feet", "yards", "miles"]
    let time = ["seconds", "minutes", "hours", "days"]
    let volume = ["milliliters", "liters", "cups", "pints", "gallons"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("What units to convert")) {
                    Picker("Unit", selection: $unit) {
                        ForEach(0 ..< units.count) {
                            //remember $ is shorthand for closures
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Unit One")) {
                    switch unit {
                    case 0 :
                        Picker("Unit", selection: $type1) {
                            ForEach(0 ..< temp.count) {
                                Text("\(self.temp[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    case 1 :
                        Picker("Unit", selection: $type1) {
                            ForEach(0 ..< length.count) {
                                Text("\(self.length[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    case 2 :
                        Picker("Unit", selection: $type1) {
                            ForEach(0 ..< time.count) {
                                Text("\(self.time[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    default :
                        Picker("Unit", selection: $type1) {
                            ForEach(0 ..< volume.count) {
                                Text("\(self.volume[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                Section(header: Text("Unit Two")) {
                    switch unit {
                    case 0 :
                        Picker("Unit", selection: $type1) {
                            ForEach(0 ..< temp.count) {
                                Text("\(self.temp[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    case 1 :
                        Picker("Unit", selection: $type1) {
                            ForEach(0 ..< length.count) {
                                Text("\(self.length[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    case 2 :
                        Picker("Unit", selection: $type1) {
                            ForEach(0 ..< time.count) {
                                Text("\(self.time[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    default :
                        Picker("Unit", selection: $type1) {
                            ForEach(0 ..< volume.count) {
                                Text("\(self.volume[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                Section {
                    TextField("Value One", text: $val1)
                        .keyboardType(.decimalPad)
                    TextField("Value Two", text: $val2)
                        .keyboardType(.decimalPad)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
