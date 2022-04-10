//
//  DebtCalcView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 4/6/22.
//

import SwiftUI
import Combine

precedencegroup ExponentiationPrecedence {
  associativity: right
  higherThan: MultiplicationPrecedence
}

infix operator ** : ExponentiationPrecedence

func ** (_ base: Double, _ exp: Double) -> Double {
  return pow(base, exp)
}

struct DebtCalc: Identifiable, Codable {
    var id = UUID()
    var rate: Double
    var amt: Double
    var time: Int
    
    func calcMonthly() -> Double {
        let totalPayments = time * 12
        let num = (rate / 100 / 12) * (1 + (rate / 100 / 12)) ** Double(totalPayments)
        let denom = ((1 + (rate / 100 / 12)) ** Double(totalPayments)) - 1
        return amt * (num / denom)
    }
    
    func calcTotal() -> Double {
        return calcMonthly() * Double(time) * 12
    }
}

struct DebtCalcView: View {
    @State private var showingSettings = false
    @State private var stringRate = ""
    @State private var stringAmt = ""
    @State private var rate = 0.0
    @State private var amt = 0.0
    @State private var setTime = 0
    @State private var showCalc = false
    @State private var invalid = false
    @State private var monthlyVal = 0.0
    @State private var totalVal = 0.0
    
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
                Text("Interest Rate")
                HStack {
                    Text("%")
                    TextField("Rate", text: $stringRate)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .onReceive(Just(stringRate)) { newValue in
                            let filtered = newValue.filter { "0123456789.".contains($0) }
                            if filtered != newValue {
                                stringRate = filtered
                            }
                        }
                }
            }
            VStack(alignment: .leading) {
                Text("Debt Amount")
                HStack {
                    Text("$")
                    TextField("Amount", text: $stringAmt)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .onReceive(Just(stringAmt)) { newValue in
                            let filtered = newValue.filter { "0123456789.".contains($0) }
                            if filtered != newValue {
                                stringAmt = filtered
                            }
                        }
                }
            }
            VStack(alignment: .leading) {
                Text("Years to Payoff")
                Picker("", selection: $setTime) {
                    ForEach(1...100, id: \.self) {
                        Text("\($0)")
                    }
                }
            }
            Button("Calculate") {
                /*if let encoded = try? JSONEncoder().encode(savedSimple.history) {
                    UserDefaults.standard.set(encoded, forKey: "SavedSimple")
                }*/
                rate = Double(stringRate) ?? 0.0
                amt = Double(stringAmt) ?? 0.0
                if (rate == 0.0 || amt == 0.0 || setTime == 0) {
                    makeInvalid()
                } else {
                    createCalc()
                    let debt = DebtCalc(rate: rate, amt: amt, time: setTime)
                    monthlyVal = debt.calcMonthly()
                    totalVal = debt.calcTotal()
                }
            }
            .alert(isPresented: $invalid) {
                Alert(
                    title: Text("Invalid"),
                    message: Text("The interest rate, amount, and time must be set"),
                    dismissButton: .default(Text("Got it!"))
                )
            }
            
            if showCalc {
                Section {
                    Text("Monthly Payment: \(stringify(value: monthlyVal))")
                        .contextMenu {
                            Button(action: {
                                UIPasteboard.general.string = String(monthlyVal)
                            }) {
                                Text("Copy monthly payment")
                            }
                        }
                    Text("Total Amount: \(stringify(value: totalVal))")
                        .contextMenu {
                            Button(action: {
                                UIPasteboard.general.string = String(totalVal)
                            }) {
                                Text("Copy total amount")
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
        .navigationTitle(Text("Debt Calculator"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DebtCalcView_Previews: PreviewProvider {
    static var previews: some View {
        DebtCalcView()
    }
}
