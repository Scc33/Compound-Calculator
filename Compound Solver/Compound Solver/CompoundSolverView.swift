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

struct CompoundSolverView: View {
    @State private var compound: CompoundCalculationModel = CompoundCalculationModel()
    @State private var savedCompounds: SaveCompounds = SaveCompounds()
    @State private var showContrib = false
    @State private var showingSettings = false
    @State var isActive: Bool = false
    @State private var calculated: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Group {
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
                    Button("Calculate") {
                        savedCompounds.save(compoundToSave: compound)
                        calculated.toggle()
                    }
                }
                if calculated {
                    Section {
                        Text("Final Value \(compound.currency.rawValue)\(String(format: "%.2f", compound.calcYearlyVals().last ?? 0))")
                        //https://www.hackingwithswift.com/articles/216/complete-guide-to-navigationview-in-swiftui
                        NavigationLink(destination: YearlyValuesView(compound: compound)) {
                            Text("Yearly Values")
                        }
                        VStack(alignment: .leading) {
                            Text("Graph")
                            Chart(data: compound.calcYearlyVals())
                                .chartStyle(
                                    ColumnChartStyle(column: Capsule().foregroundColor(.green), spacing: 2)
                                ).frame(height: 200)
                        }
                    }
                }
                Section {
                    NavigationLink(destination: HistoryView(currCompound: compound, History: savedCompounds, rootIsActive: $isActive), isActive: $isActive) {
                        Text("History")
                    }
                    .isDetailLink(false)
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
                MenuView(compoundCalcModel: compound)
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
