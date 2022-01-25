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

enum compoundType: String, Equatable, CaseIterable, Identifiable {
    case day = "Daily"
    case week = "Weekly"
    case month = "Montly"
    case quarter = "Quarterly"
    case year = "Yearly"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
    var id: String { self.rawValue }
}

struct CompoundSolverView: View {
    @State private var rate = ""
    @State private var initial = ""
    @State private var time = ""
    @State private var contributionAmt = ""
    @State private var numberContrib = ""
    @State private var compounding: compoundType = .day
    @State private var graphing: graphType = .bar
    @State private var showContrib = false
    @State private var showingSettings = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack(alignment: .leading) {
                        Text("Interest Rate")
                        TextField("Rate", text: $rate)
                            .keyboardType(.decimalPad)
                    }
                    VStack(alignment: .leading) {
                        Text("Initial Principal")
                        TextField("Amount", text: $initial)
                            .keyboardType(.decimalPad)
                    }
                    VStack(alignment: .leading) {
                        Text("Years of Growing")
                        TextField("Years", text: $time)
                            .keyboardType(.decimalPad)
                    }
                    VStack(alignment: .leading) {
                        Text("Monthly Contribution")
                        TextField("Addition", text: $contributionAmt)
                            .keyboardType(.decimalPad)
                    }
                    VStack(alignment: .leading) {
                        Text("Compound Frequency")
                        Picker("", selection: $compounding) {
                            ForEach(compoundType.allCases, id: \.id) { value in
                                Text(value.localizedName)
                                    .tag(value)
                            }
                        }
                    }
                }
                Section {
                    Text("Final Value $\(String(format: "%.2f", calcYearlyVals(rate: rate, initial: initial, time: time, contributionAmt: contributionAmt, compounding: compounding).last ?? 0))")
                    //https://www.hackingwithswift.com/articles/216/complete-guide-to-navigationview-in-swiftui
                    NavigationLink(destination: YearlyValuesView(rate: rate, initial: initial, time: time, contributionAmt: contributionAmt, compounding: compounding)) {
                        Text("Yearly Values")
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
                    case .bar : Chart(data: calcYearlyVals(rate: rate, initial: initial, time: time, contributionAmt: contributionAmt, compounding: compounding))
                            .chartStyle(
                                ColumnChartStyle(column: Capsule().foregroundColor(.green), spacing: 2)
                            ).frame(height: 200)
                    default : Chart(data: calcYearlyVals(rate: rate, initial: initial, time: time, contributionAmt: contributionAmt, compounding: compounding))
                            .chartStyle(
                                LineChartStyle(.quadCurve, lineColor: .blue, lineWidth: 5)
                            ).frame(height: 200)
                    }
                }
                Section {
                    HistoryView()
                }
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
