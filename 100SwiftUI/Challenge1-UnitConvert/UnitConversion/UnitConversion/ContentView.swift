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
    @State private var type1 = ""
    @State private var type2 = ""
    let units = ["temp", "length", "time", "volume"]
    let temp = ["Celsius", "Fahrenheit", "Kelvin"]
    let length = ["meters", "kilometers", "feet", "yards", "miles"]
    let time = ["seconds", "minutes", "hours", "days"]
    let volume = ["milliliters", "liters", "cups", "pints", "gallons"]
    
    @ViewBuilder
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
                    if (unit == 0) {
                        Picker("Unit", selection: $type1) {
                            ForEach(0 ..< temp.count) {
                                Text("\(self.units[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        type1 = "Celsius"
                    } else if unit == 1 {
                        Picker("Unit", selection: $type1) {
                            ForEach(0 ..< length.count) {
                                Text("\(self.units[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        type1 = "meters"
                    } else if unit == 2 {
                        Picker("Unit", selection: $type1) {
                            ForEach(0 ..< time.count) {
                                Text("\(self.units[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        type1 = "seconds"
                    } else {
                        Picker("Unit", selection: $type1) {
                            ForEach(0 ..< volume.count) {
                                Text("\(self.units[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        type1 = "milliliters"
                    }
                }
                Section(header: Text("Unit Two")) {
                    if unit == 0 {
                        Picker("Unit", selection: $type1) {
                            ForEach(0 ..< temp.count) {
                                Text("\(self.units[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        type1 = "Celsius"
                    } else if unit == 1 {
                        Picker("Unit", selection: $type1) {
                            ForEach(0 ..< length.count) {
                                Text("\(self.units[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        type1 = "meters"
                    } else if unit == 2 {
                        Picker("Unit", selection: $type1) {
                            ForEach(0 ..< time.count) {
                                Text("\(self.units[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        type1 = "seconds"
                    } else {
                        Picker("Unit", selection: $type1) {
                            ForEach(0 ..< volume.count) {
                                Text("\(self.units[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        type1 = "milliliters"
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
