//
//  AnnualRateOfReturnView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 4/10/22.
//

import SwiftUI
import Combine

struct AnnualRateOfReturn: Identifiable, Codable {
    var id = UUID()
    var start: Double
    var end: Double
    var time: Int
    
    func calcAnnualRateOfReturn() -> Double {
        return (((end / start) ** (1.0 / Double(time))) - 1.0) * 100
    }
}

struct AnnualRateOfReturnView: View {
    @State private var stringStart = ""
    @State private var stringEnd = ""
    @State private var start = 0.0
    @State private var end = 0.0
    @State private var setTime = 0
    @State private var showCalc = false
    @State private var invalid = false
    @State private var ARR = 0.0
    @State private var finalValue = 0.0
    
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
                    TextField("Amount", text: $stringStart)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .onReceive(Just(stringStart)) { newValue in
                            let filtered = newValue.filter { "0123456789.".contains($0) }
                            if filtered != newValue {
                                stringStart = filtered
                            }
                        }
                }
            }
            VStack(alignment: .leading) {
                Text("Ending Value")
                HStack {
                    Text("$")
                    TextField("Amount", text: $stringEnd)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .onReceive(Just(stringEnd)) { newValue in
                            let filtered = newValue.filter { "0123456789.".contains($0) }
                            if filtered != newValue {
                                stringEnd = filtered
                            }
                        }
                }
            }
            VStack(alignment: .leading) {
                Text("Years of Growth")
                Picker("", selection: $setTime) {
                    ForEach(1...100, id: \.self) {
                        Text("\($0)")
                    }
                }
            }
            Button("Calculate") {
                start = Double(stringStart) ?? 0.0
                end = Double(stringEnd) ?? 0.0
                if (start == 0.0 || end == 0.0 || setTime == 0) {
                    makeInvalid()
                } else {
                    createCalc()
                    let ARRCalc = AnnualRateOfReturn(start: start, end: end, time: setTime)
                    ARR = ARRCalc.calcAnnualRateOfReturn()
                    let perGrowth = PercentGrowth(startVal: start, endVal: end)
                    finalValue = perGrowth.calcPercent()
                }
            }
            .alert(isPresented: $invalid) {
                Alert(
                    title: Text("Invalid"),
                    message: Text("The interest rate, principal, and time must be set"),
                    dismissButton: .default(Text("Got it!"))
                )
            }
            
            if showCalc {
                Section {
                    Text("Annualized Return: \(String(format:"%.2f", ARR))%")
                        .contextMenu {
                            Button(action: {
                                UIPasteboard.general.string = String(ARR)
                            }) {
                                Text("Copy Annualized Return")
                            }
                        }
                    Text("Total Return: \(String(format:"%.2f", finalValue))%")
                        .contextMenu {
                            Button(action: {
                                UIPasteboard.general.string = String(finalValue)
                            }) {
                                Text("Copy total return")
                            }
                        }
                }
            }
        }
        /*.toolbar {
            Button {
                self.showingSettings.toggle()
            } label: {
                Image(systemName: "questionmark.circle")
            }
        }.sheet(isPresented: $showingSettings) {
            SettingMenuView()
        }*/
        .navigationTitle(Text("Annual Rate Of ReturnView"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AnnualRateOfReturnView_Previews: PreviewProvider {
    static var previews: some View {
        AnnualRateOfReturnView()
    }
}
