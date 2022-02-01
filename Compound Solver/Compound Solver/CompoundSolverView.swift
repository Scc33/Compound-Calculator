//
//  CompoundSolverView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/24/22.
//

import SwiftUI
import Charts
import Combine

enum currencyType: String, Equatable, CaseIterable, Identifiable, Codable {
    case dollar = "$"
    case euro = "€"
    case pound = "£"
    case yen = "¥"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
    var id: String { self.rawValue }
}

enum compoundType: String, Equatable, CaseIterable, Identifiable, Codable {
    case day = "Daily"
    case week = "Weekly"
    case biWeekly = "Every two weeks"
    case month = "Monthly"
    case quarter = "Quarterly"
    case semiYearly = "Semi-yearly"
    case year = "Yearly"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
    var id: String { self.rawValue }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

func stringify(value: Double) -> String{
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 2;
    return formatter.string(from: NSNumber(value: value)) ?? ""
}

struct CompoundSolverView: View {
    @State private var compound: CompoundCalculationModel = CompoundCalculationModel()
    @ObservedObject private var savedCompounds: SaveCompounds = SaveCompounds()
    @State private var showingSettings = false
    @State var isActive: Bool = false
    @State private var calculated: Bool = false
    
    @State private var yearlyVals: [Double] = []
    @State private var graphVals: [Double] = []
    @State private var contrib: Double = 0.0
    @State private var profit: Double = 0.0
    
    @State private var rate = ""
    @State private var initial = ""
    @State private var contributionAmt = ""
    @State private var setTime = 0
    
    @State private var invalid = false
    
    func createGraph() {
        if calculated == false {
            calculated = true
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Group {
                        VStack(alignment: .leading) {
                            Text("Interest Rate")
                            HStack {
                                Text("%")
                                TextField("Rate", text: $rate)
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                                    .onReceive(Just(rate)) { newValue in
                                        let filtered = newValue.filter { "0123456789.".contains($0) }
                                        if filtered != newValue {
                                            rate = filtered
                                        }
                                    }
                            }
                        }
                        VStack(alignment: .leading) {
                            Text("Initial Principal")
                            HStack {
                                Text(compound.currency.rawValue)
                                TextField("Amount", text: $initial)
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                                    .onReceive(Just(initial)) { newValue in
                                        let filtered = newValue.filter { "0123456789.".contains($0) }
                                        if filtered != newValue {
                                            initial = filtered
                                        }
                                    }
                            }
                        }
                        VStack(alignment: .leading) {
                            Text("Monthly Contribution")
                            HStack {
                                Text(compound.currency.rawValue)
                                TextField("Addition", text: $contributionAmt)
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                                    .onReceive(Just(contributionAmt)) { newValue in
                                        let filtered = newValue.filter { "0123456789.".contains($0) }
                                        if filtered != newValue {
                                            contributionAmt = filtered
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
                        VStack(alignment: .leading) {
                            Text("Compound Frequency")
                            Picker("", selection: $compound.compounding) {
                                ForEach(compoundType.allCases, id: \.id) { value in
                                    Text(value.localizedName)
                                        .tag(value)
                                }
                            }
                        }
                    }
                    Button("Calculate") {
                        compound.rate = Double(rate) ?? 0.0
                        compound.initial = Double(initial) ?? 0.0
                        compound.contributionAmt = Double(contributionAmt) ?? 0.0
                        compound.time = setTime
                        if (compound.time <= 0) {
                            invalid = true
                        } else {
                            let newCompound = compound
                            savedCompounds.save(compoundToSave: newCompound)
                            createGraph()
                            hideKeyboard()
                            yearlyVals = compound.calcYearlyVals()
                            graphVals = compound.graphYearlyVals()
                            contrib = compound.calcContrib()
                            profit = compound.calcProfit()
                        }
                        if let encoded = try? JSONEncoder().encode(savedCompounds.savedCompounds) {
                            UserDefaults.standard.set(encoded, forKey: "SavedCompound")
                        }
                    }
                    .alert(isPresented: $invalid) {
                        Alert(
                            title: Text("Invalid"),
                            message: Text("The years of growth must be selected"),
                            dismissButton: .default(Text("Got it!"))
                        )
                    }
                }
                if calculated {
                    Section {
                        //https://developer.apple.com/documentation/swiftui/text/textselection(_:)
                        Text("Final Value - \(compound.currency.rawValue)\(stringify(value: yearlyVals.last ?? 0))")
                            .contextMenu {
                                Button(action: {
                                    UIPasteboard.general.string = String((yearlyVals.last ?? 0))
                                }) {
                                    Text("Copy final value")
                                }
                            }
                        Text("Total Contribution - \(compound.currency.rawValue)\(stringify(value: contrib))")
                            .contextMenu {
                                Button(action: {
                                    UIPasteboard.general.string = String(contrib)
                                }) {
                                    Text("Copy total contribution")
                                }
                            }
                        Text("Total Profit - \(compound.currency.rawValue)\(stringify(value: profit))")
                            .contextMenu {
                                Button(action: {
                                    UIPasteboard.general.string = String(profit)
                                }) {
                                    Text("Copy total profit")
                                }
                            }
                        if compound.time > 0 {
                            NavigationLink(destination: YearlyValuesView(compound: compound)) {
                                Text("Yearly Values")
                            }
                            Chart(data: graphVals)
                                .chartStyle(
                                    ColumnChartStyle(column: Capsule().foregroundColor(.green), spacing: 2)
                                ).frame(height: 400)
                        }
                    }
                }
                if calculated {
                    Section {
                        NavigationLink(destination: CompoundHistoryView(currCompound: $compound, history: savedCompounds, rootIsActive: $isActive, calculated: $calculated, rate: $rate, initial: $initial, contributionAmt: $contributionAmt, setTime: $setTime), isActive: $isActive) {
                            Text("History")
                        }
                        .isDetailLink(false)
                    }
                }
                /*NavigationLink(destination: ChartsEx()) {
                 Text("Example")
                 }*/
                //Banner()
            }
            .toolbar {
                Button {
                    self.showingSettings.toggle()
                } label: {
                    Image(systemName: "gear")
                }
            }.sheet(isPresented: $showingSettings) {
                CompoundMenuView(compoundCalcModel: $compound)
            }
            .navigationTitle(Text("Compound Solver"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CompoundSolverView_Previews: PreviewProvider {
    static var previews: some View {
        CompoundSolverView()
    }
}
