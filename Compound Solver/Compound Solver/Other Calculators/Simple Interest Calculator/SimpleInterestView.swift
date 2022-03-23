//
//  SimpleInterestView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 2/8/22.
//

import SwiftUI
import Combine

struct SimpleInterestView: View {
    @State private var showingSettings = false
    @State private var stringInterest = ""
    @State private var stringPrincipal = ""
    @State private var interest = 0.0
    @State private var principal = 0.0
    @State private var setTime = 0
    //@State private var savedSimple = SaveSimple()
    @State private var showCalc = false
    @State private var invalid = false
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
                Text("Interest Rate")
                HStack {
                    Text("%")
                    TextField("Rate", text: $stringInterest)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .onReceive(Just(stringInterest)) { newValue in
                            let filtered = newValue.filter { "0123456789.".contains($0) }
                            if filtered != newValue {
                                stringInterest = filtered
                            }
                        }
                }
            }
            VStack(alignment: .leading) {
                Text("Principal")
                HStack {
                    Text("$")
                    TextField("Amount", text: $stringPrincipal)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .onReceive(Just(stringPrincipal)) { newValue in
                            let filtered = newValue.filter { "0123456789.".contains($0) }
                            if filtered != newValue {
                                stringPrincipal = filtered
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
                /*if let encoded = try? JSONEncoder().encode(savedSimple.history) {
                    UserDefaults.standard.set(encoded, forKey: "SavedSimple")
                }*/
                interest = Double(stringInterest) ?? 0.0
                principal = Double(stringPrincipal) ?? 0.0
                if (interest == 0.0 || principal == 0.0 || setTime == 0) {
                    makeInvalid()
                } else {
                    createCalc()
                    let simp = SimpleInterest(interest: interest, principal: principal, time: setTime)
                    finalValue = simp.calcInterest()
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
                    Text("Final value: $\(String(format:"%.2f", finalValue))")
                        .contextMenu {
                            Button(action: {
                                UIPasteboard.general.string = String(finalValue)
                            }) {
                                Text("Copy final value")
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
        .navigationTitle(Text("Simple Interest"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SimpleInterestView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleInterestView()
    }
}
