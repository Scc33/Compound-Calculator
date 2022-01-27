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
    @State private var showContrib = false
    @State private var showingSettings = false
    @State var isActive: Bool = false
    @State private var calculated: Bool = false
    
    var disableForm: Bool {
        compound.rate == 0.0 || compound.initial == 0.0 || compound.time == 0
    }
    
    let formatterDecimal: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    let formatterNone: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Group {
                        VStack(alignment: .leading) {
                            Text("Interest Rate")
                            TextField("Rate", value: $compound.rate, formatter: formatterDecimal)
                                .keyboardType(.decimalPad)
                        }
                        VStack(alignment: .leading) {
                            Text("Initial Principal")
                            TextField("Amount", value: $compound.initial, formatter: formatterDecimal)
                                .keyboardType(.decimalPad)
                        }
                        VStack(alignment: .leading) {
                            Text("Years of Growing")
                            TextField("Years", value: $compound.time, formatter: formatterNone)
                                .keyboardType(.numberPad)
                        }
                        VStack(alignment: .leading) {
                            Text("Monthly Contribution")
                            TextField("Addition", value: $compound.contributionAmt, formatter: formatterDecimal)
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
                        let newCompound = compound
                        savedCompounds.save(compoundToSave: newCompound)
                        calculated.toggle()
                        hideKeyboard()
                        print(savedCompounds)
                    }
                }
                if calculated {
                    Section {
                        Text("Final Value \(compound.currency.rawValue)\(String(format: "%.2f", compound.calcYearlyVals.last ?? 0))")
                        //https://www.hackingwithswift.com/articles/216/complete-guide-to-navigationview-in-swiftui
                        NavigationLink(destination: YearlyValuesView(compound: compound)) {
                            Text("Yearly Values")
                        }
                        VStack(alignment: .leading) {
                            Chart(data: compound.graphYearlyVals)
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
    }
}

struct CompoundSolverView_Previews: PreviewProvider {
    static var previews: some View {
        CompoundSolverView()
    }
}
