//
//  DoubleView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/24/22.
//

// The rule of 72
// https://en.wikipedia.org/wiki/Rule_of_72#E-M_rule
// maybe include a link to this and the formulas under the settings

import SwiftUI
import Combine

struct DoubleView: View {
    @State private var interest = 0.0
    @State private var showTime = false
    @State private var invalid = false
    @State private var time = 0.0
    @State private var saveDoubles = SaveDoubles()
    @State var isActive: Bool = false
    @State private var showingSettings = false
    
    @State private var stringInterest = ""
    
    func createTime() {
        if showTime == false {
            invalid = false
            showTime = true
        }
    }
    
    func makeInvalid() {
        if invalid == false {
            invalid = true
            showTime = false
        }
    }
    
    func excDouble() -> Double {
        let num = log(2.0)
        let dem = log(1.0 + (interest / 100.0))
        return num / dem
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
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
                    Button("Calculate") {
                        interest = Double(stringInterest) ?? 0.0
                        hideKeyboard()
                        print(interest)
                        if (interest == 0.0) {
                            makeInvalid()
                        } else {
                            createTime()
                            saveDoubles.save(doubleToSave: interest)
                            time = excDouble()
                        }
                    }
                    .alert(isPresented: $invalid) {
                        Alert(
                            title: Text("Invalid"),
                            message: Text("The interest rate must be greater than 0% to double"),
                            dismissButton: .default(Text("Got it!"))
                        )
                    }
                }
                if showTime {
                    Section {
                        Text("Doubling time \(String(format:"%.2f",time)) years")
                            .contextMenu {
                                Button(action: {
                                    UIPasteboard.general.string = String(time)
                                }) {
                                    Text("Copy")
                                }
                            }
                    }
                }
                if showTime {
                    Section {
                        NavigationLink(destination: DoubleHistoryView(interest: $interest, history: saveDoubles, rootIsActive: $isActive, showTime: $showTime), isActive: $isActive) {
                            Text("History")
                        }
                        .isDetailLink(false)
                    }
                }
            }
            .toolbar {
                Button {
                    self.showingSettings.toggle()
                } label: {
                    Image(systemName: "gear")
                }
            }.sheet(isPresented: $showingSettings) {
                DoubleMenuView()
            }
            .navigationTitle(Text("Doubling Calculator"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct DoubleView_Previews: PreviewProvider {
    static var previews: some View {
        DoubleView()
    }
}
