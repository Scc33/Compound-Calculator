//
//  CompoundSolverView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/24/22.
//

import SwiftUI
import Charts

struct CompoundSolverView: View {
    @State private var rate = ""
    @State private var initial = ""
    @State private var time = ""
    @State private var contributionAmt = ""
    @State private var numberContrib = ""
    @State private var compounding: compoundType = .day
    @State private var graphing: graphType = .bar
    @State private var isContrib = false
    @State private var showContrib = false
    @State private var showingSettings = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Rate", text: $rate)
                        .keyboardType(.decimalPad)
                    HStack {
                        TextField("Initial amount", text: $initial)
                            .keyboardType(.decimalPad)
                        TextField("Years", text: $time)
                            .keyboardType(.decimalPad)
                    }
                    Toggle(isOn: $isContrib) {
                        Text("Contributions")
                    }
                    TextField("Monthly Contribution", text: $contributionAmt)
                        .keyboardType(.decimalPad)
                    .isEmpty(!isContrib)
                    Picker("Base", selection: $compounding) {
                        ForEach(compoundType.allCases, id: \.id) { value in
                            Text(value.localizedName)
                                .tag(value)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    Text("Final Value \(calcYearlyVals(rate: rate, initial: initial, time: time, contributionAmt: contributionAmt, compounding: compounding).last ?? 0)")
                    //https://www.hackingwithswift.com/articles/216/complete-guide-to-navigationview-in-swiftui
                    NavigationLink(destination: YearlyValues(rate: rate, initial: initial, time: time, contributionAmt: contributionAmt, compounding: compounding)) {
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
                    case .bar : Chart(data: [0.1, 0.3, 0.2, 0.5, 0.4, 0.9, 0.1])
                            .chartStyle(
                                ColumnChartStyle(column: Capsule().foregroundColor(.green), spacing: 2)
                            ).frame(height: 200)
                    default : Chart(data: [0.1, 0.3, 0.2, 0.5, 0.4, 0.9, 0.1])
                            .chartStyle(
                                LineChartStyle(.quadCurve, lineColor: .blue, lineWidth: 5)
                            ).frame(height: 200)
                    }
                }
                Section {
                    History()
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
