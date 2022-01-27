//
//  CompoundSolverView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/24/22.
//

import SwiftUI
import Charts

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

struct CompoundSolverView: View {
    @State private var compound: CompoundCalculationModel = CompoundCalculationModel()
    @ObservedObject private var savedCompounds: SaveCompounds = SaveCompounds()
    @State private var showingSettings = false
    @State var isActive: Bool = false
    @State private var calculated: Bool = false
    
    @State private var yearlyVals: [Double] = []
    @State private var graphVals: [Double] = []
    
    func createGraph() {
        if calculated == false {
            calculated = true
        }
    }
    
    let formatterDecimal: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Group {
                        VStack(alignment: .leading) {
                            Text("Interest Rate")
                            HStack {
                                Text("%")
                                TextField("Rate", value: $compound.rate, formatter: formatterDecimal)
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                        VStack(alignment: .leading) {
                            Text("Initial Principal")
                            HStack {
                                Text("$")
                                TextField("Amount", value: $compound.initial, formatter: formatterDecimal)
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                        VStack(alignment: .leading) {
                            Text("Monthly Contribution")
                            HStack {
                                Text("$")
                                TextField("Addition", value: $compound.contributionAmt, formatter: formatterDecimal)
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                        VStack(alignment: .leading) {
                            Text("Years of Growth")
                            Picker("", selection: $compound.time) {
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
                        let newCompound = compound
                        savedCompounds.save(compoundToSave: newCompound)
                        createGraph()
                        hideKeyboard()
                        yearlyVals = compound.calcYearlyVals()
                        graphVals = compound.graphYearlyVals()
                    }
                }
                if calculated {
                    Section {
                        Text("Final Value \(compound.currency.rawValue)\(String(format: "%.2f", yearlyVals.last ?? 0))")
                        NavigationLink(destination: YearlyValuesView(compound: compound)) {
                            Text("Yearly Values")
                        }
                        VStack(alignment: .leading) {
                            Chart(data: graphVals)
                                .chartStyle(
                                    ColumnChartStyle(column: Capsule().foregroundColor(.green), spacing: 2)
                                ).frame(height: 200)
                        }
                    }
                }
                if calculated {
                    Section {
                        NavigationLink(destination: HistoryView(currCompound: $compound, history: savedCompounds, rootIsActive: $isActive), isActive: $isActive) {
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
                MenuView(compoundCalcModel: compound)
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
