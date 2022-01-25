//
//  CompoundSolverView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/24/22.
//

import SwiftUI
import Charts

enum graphType: String, Equatable, CaseIterable, Identifiable {
    case bar = "Bar graph"
    case line = "Line graph"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
    var id: String { self.rawValue }
}

enum currencyType: String, Equatable, CaseIterable, Identifiable {
    case dollar = "$"
    case euro = "€"
    case pound = "£"
    case yen = "¥"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
    var id: String { self.rawValue }
}

enum compoundType: String, Equatable, CaseIterable, Identifiable {
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

struct CompoundSolverView: View {
    @State private var compound: CompoundCalculationModel = CompoundCalculationModel()
    @State private var savedCompounds: SaveCompounds = SaveCompounds()
    @State private var graphing: graphType = .bar
    @State private var showContrib = false
    @State private var showingSettings = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack(alignment: .leading) {
                        Text("Interest Rate")
                        TextField("Rate", text: $compound.rate)
                            .keyboardType(.decimalPad)
                    }
                    VStack(alignment: .leading) {
                        Text("Initial Principal")
                        TextField("Amount", text: $compound.initial)
                            .keyboardType(.decimalPad)
                    }
                    VStack(alignment: .leading) {
                        Text("Years of Growing")
                        TextField("Years", text: $compound.time)
                            .keyboardType(.decimalPad)
                    }
                    VStack(alignment: .leading) {
                        Text("Monthly Contribution")
                        TextField("Addition", text: $compound.contributionAmt)
                            .keyboardType(.decimalPad)
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
                Section {
                    Text("Final Value $\(String(format: "%.2f", compound.calcYearlyVals().last ?? 0))")
                    //https://www.hackingwithswift.com/articles/216/complete-guide-to-navigationview-in-swiftui
                    NavigationLink(destination: YearlyValuesView(compound: compound)) {
                        Text("Yearly Values")
                    }
                    Button("Save") {
                        savedCompounds.save(compoundToSave: compound)
                    }
                }
                Section {
                    Toggle(isOn: $showContrib) {
                        Text("Show contributions")
                    }
                    Picker("Base", selection: $graphing) {
                        ForEach(graphType.allCases, id: \.id) { value in
                            Text(value.localizedName)
                                .tag(value)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    switch graphing {
                    case .bar : Chart(data: compound.calcYearlyVals())
                            .chartStyle(
                                ColumnChartStyle(column: Capsule().foregroundColor(.green), spacing: 2)
                            ).frame(height: 200)
                    default : Chart(data: compound.calcYearlyVals())
                            .chartStyle(
                                LineChartStyle(.quadCurve, lineColor: .blue, lineWidth: 5)
                            ).frame(height: 200)
                    }
                }
                Section {
                    NavigationLink(destination: HistoryView(History: savedCompounds)) {
                        Text("History")
                    }
                }
                //Banner()
            }
            .toolbar {
                Button {
                    self.showingSettings.toggle()
                } label: {
                    Image(systemName: "gear")
                }
            }.sheet(isPresented: $showingSettings) {
                // show an AddView here
                MenuView()
            }
            .navigationTitle(Text("Compound Solver"))
        }
    }
}

struct CompoundSolverView_Previews: PreviewProvider {
    static var previews: some View {
        CompoundSolverView()
    }
}
