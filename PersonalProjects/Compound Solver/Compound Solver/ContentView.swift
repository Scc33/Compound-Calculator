//
//  ContentView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 8/1/21.
//

// The rule of 72
// https://en.wikipedia.org/wiki/Rule_of_72#E-M_rule
// maybe include a link to this and the formulas under the settings

import SwiftUI
import Foundation
import Charts

func calcYearlyVals(rate: String, initial: String, time: String, contributionAmt: String, numberContrib: String) -> [Double] {
    let cRate = Double(rate) ?? 0
    let cInitial = Double(initial) ?? 0
    let cTime = Int(time) ?? 0
    let cContributionAmt = Double(contributionAmt) ?? 0
    let cNumberContrib = Double(numberContrib) ?? 0
    
    var calcVals = [cInitial]
    
    for _ in 0 ..< cTime {
        var currVal = calcVals.last ?? 0
        currVal += (cContributionAmt * cNumberContrib)
        currVal = currVal * pow((1 + (cRate / cNumberContrib)), cNumberContrib)
        calcVals.append(currVal)
    }
    
    return calcVals
}

struct YearlyValues: View {
    var rate: String
    var initial: String
    var time: String
    var contributionAmt: String
    var numberContrib: String
    
    var vals: [Double] {
        return calcYearlyVals(rate: rate, initial: initial, time: time, contributionAmt: contributionAmt, numberContrib: numberContrib)
    }
    
    var body: some View {
        return List {
            ForEach(vals, id: \.self) { val in
                Text("\(val)")
            }
        }
    }
}

struct History: View {
    var body: some View {
        Text("History")
    }
}

//https://medium.com/macoclock/conditional-views-in-swiftui-dc09c808bc30
struct EmptyModifier: ViewModifier {
    let isEmpty: Bool
    
    func body(content: Content) -> some View {
        Group {
            if isEmpty {
                EmptyView()
            } else {
                content
            }
        }
    }
}

//https://medium.com/macoclock/conditional-views-in-swiftui-dc09c808bc30
extension View {
    func isEmpty(_ bool: Bool) -> some View {
        modifier(EmptyModifier(isEmpty: bool))
    }
}

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
    
    var body: some View {
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
                HStack {
                    TextField("Contributions per Year", text: $numberContrib)
                    TextField("Contribution amount", text: $contributionAmt)
                        .keyboardType(.decimalPad)
                }.isEmpty(!isContrib)
                Picker("Base", selection: $compounding) {
                    ForEach(compoundType.allCases, id: \.id) { value in
                        Text(value.localizedName)
                            .tag(value)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            Section {
                Text("Final Value \(calcYearlyVals(rate: rate, initial: initial, time: time, contributionAmt: contributionAmt, numberContrib: numberContrib).last ?? 0)")
                //https://www.hackingwithswift.com/articles/216/complete-guide-to-navigationview-in-swiftui
                NavigationLink(destination: YearlyValues(rate: rate, initial: initial, time: time, contributionAmt: contributionAmt, numberContrib: numberContrib)) {
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
    }
}


struct ContentView: View {
    @State private var selectedTab = 0
    @State private var showingSettings = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                CompoundSolverView()
                    .navigationTitle(Text("Compound Solver"))
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
            }
            .tabItem {
                Text("Compound")
                Image(systemName:"waveform.path.ecg.rectangle")
            }.tag(0)
            DoubleView()
            .tabItem {
                Text("Doubling Calculator")
                Image(systemName:"waveform.path.ecg.rectangle")
            }.tag(1)
            FormulaView()
            .tabItem {
                Text("Formula")
                Image(systemName:"waveform.path.ecg.rectangle")
            }.tag(2)
        }
    }
}

enum topLine: String, Equatable, CaseIterable, Identifiable {
    case exact = "69.3"
    case seventy = "70"
    case seventyTwo = "72"
    
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

enum graphType: String, Equatable, CaseIterable, Identifiable {
    case bar = "Bar graph"
    case line = "Line graph"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
    var id: String { self.rawValue }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
