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
    @State private var type1 = 0
    @State private var type2 = 0
    let temp = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var finalTemp: Double {
        let v1 = Double(val1) ?? 0
        var u1:UnitTemperature
        var u2:UnitTemperature
        
        switch type1 {
        case 0 :
            u1 = UnitTemperature.celsius
        case 1 :
            u1 = UnitTemperature.fahrenheit
        default:
            u1 = UnitTemperature.kelvin
        }
        switch type2 {
        case 0 :
            u2 = UnitTemperature.celsius
        case 1 :
            u2 = UnitTemperature.fahrenheit
        default:
            u2 = UnitTemperature.kelvin
        }
        
        let t = Measurement(value: v1, unit: u1)
        return t.converted(to: u2).value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Unit One")) {
                        Picker("Unit", selection: $type1) {
                            ForEach(0 ..< temp.count) {
                                Text("\(self.temp[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Unit Two")) {
                    if unit == 0 {
                        Picker("Unit", selection: $type2) {
                            ForEach(0 ..< temp.count) {
                                Text("\(self.temp[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                Section {
                    TextField("Value", text: $val1)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Final Temp")) {
                    Text("\(finalTemp, specifier: "%.2f") \(temp[type2])")
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
