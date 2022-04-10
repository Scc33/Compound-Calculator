//
//  PercentageGrowthView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 2/8/22.
//

import SwiftUI
import Combine

struct PercentGrowth: Identifiable, Codable {
    var id = UUID()
    var startVal: Double
    var endVal: Double
    
    func calcPercent() -> Double {
        return ((endVal - startVal) / startVal) * 100
    }
}


struct PercentageGrowthView: View {
    @State private var showingSettings = false
    @State private var startVal = ""
    @State private var endVal = ""
    @State private var startDouble = 0.0
    @State private var endDouble = 0.0
    @State private var showCalc = false
    @State private var invalid = false
    @State private var percent = 0.0
    
    func createCalc() {
        if showCalc == false {
            invalid = false
            showCalc = true
        }
    }
    
    func makeInvalid() {
        if invalid == false {
            invalid = true
            showCalc = false
        }
    }

    var body: some View {
        Form {
            VStack(alignment: .leading) {
                Text("Starting Value")
                HStack {
                    Text("$")
                    TextField("Start", text: $startVal)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .onReceive(Just(startVal)) { newValue in
                            let filtered = newValue.filter { "0123456789.".contains($0) }
                            if filtered != newValue {
                                startVal = filtered
                            }
                        }
                }
            }
            VStack(alignment: .leading) {
                Text("Ending Value")
                HStack {
                    Text("$")
                    TextField("Final", text: $endVal)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .onReceive(Just(endVal)) { newValue in
                            let filtered = newValue.filter { "0123456789.".contains($0) }
                            if filtered != newValue {
                                endVal = filtered
                            }
                        }
                }
            }
            Button("Calculate") {
                /*if let encoded = try? JSONEncoder().encode(savedSimple.history) {
                    UserDefaults.standard.set(encoded, forKey: "SavedSimple")
                }*/
                startDouble = Double(startVal) ?? 0.0
                endDouble = Double(endVal) ?? 0.0
                if (startDouble == 0.0 || endDouble == 0.0) {
                    makeInvalid()
                } else {
                    createCalc()
                    let perc = PercentGrowth(startVal: startDouble, endVal: endDouble)
                    percent = perc.calcPercent()
                }
            }
            .alert(isPresented: $invalid) {
                Alert(
                    title: Text("Invalid"),
                    message: Text("The start and final value must be set"),
                    dismissButton: .default(Text("Got it!"))
                )
            }
            
            if showCalc {
                Section {
                    Text("Percent Growth: \(String(format:"%.2f", percent))%")
                        .contextMenu {
                            Button(action: {
                                UIPasteboard.general.string = String(percent)
                            }) {
                                Text("Copy final value")
                            }
                        }
                }
            }
        }
        .navigationTitle(Text("Percent Growth"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PercentageGrowthView_Previews: PreviewProvider {
    static var previews: some View {
        PercentageGrowthView()
    }
}
