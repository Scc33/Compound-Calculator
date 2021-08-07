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

struct MenuView: View {
    @State private var isShareSheetShowing = false
    
    func shareButton() {
        isShareSheetShowing.toggle()
        let url = URL(string: "https://apple.com")
        let activityView = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: shareButton) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.largeTitle)
                }
                Image(systemName:  "gearshape")
                    .font(.largeTitle)
            }
            HStack {
                Text("Compound Interest")
                Text("A = P (1 + r/n) ") + Text("nt").font(.system(.footnote)).baselineOffset(10)
            }
            HStack {
                Text("Future Value of a series")
                Text("FV = PMT (1 + r/n) ") + Text("nt").font(.system(.footnote)).baselineOffset(10) + Text("-1 / (r/n)")
            }
            Text("8") + Text("2").font(.system(.footnote)).baselineOffset(10)
            Text("Privacy Policy/Website")
        }
    }
}

struct DoubleView: View {
    @State private var estBase: topLine = .seventy
    @State private var estInterest = ""
    
    var excDouble: Double {
        let convertedEstInterest = Double(estInterest) ?? 0.1
        let num = log(2.0)
        let dem = log(1.0 + (convertedEstInterest / 100.0))
        return num / dem
    }
    
    var estDouble: Double {
        let convertedEstBase = Double(estBase.id) ?? 0.1
        let convertedEstInterest = Double(estInterest) ?? 0.1
        return convertedEstBase / convertedEstInterest
    }
    
    var body: some View {
        Form {
            Section {
                Picker("Base", selection: $estBase) {
                    ForEach(topLine.allCases, id: \.id) { value in
                        Text(value.localizedName)
                            .tag(value)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                TextField("Interest Rate", text: $estInterest)
                    .keyboardType(.decimalPad)
            }
            Section {
                Text("Estimated doubling time \(estDouble)")
                Text("Exact doubling time \(excDouble)")
            }
        }
    }
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
    @State private var selectedYear = 2019
    @State private var barChartEntries: [BarChartDataEntry] = []
    
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
                Text("Graph selected year \(selectedYear)")
                Button("Change Year") {
                    if selectedYear == 2019 {
                        selectedYear = 2020
                    } else {
                        selectedYear = 2019
                    }
                }
                TransactionBarChartView(entries: Transaction.dataEntriiesForYear(selectedYear, transactions: Transaction.allTransactions), selectedYear: $selectedYear).frame(height: 200)
            }
            Section {
                //https://www.hackingwithswift.com/articles/216/complete-guide-to-navigationview-in-swiftui
                NavigationLink(destination: YearlyValues(rate: rate, initial: initial, time: time, contributionAmt: contributionAmt, numberContrib: numberContrib)) {
                    Text("Yearly Values")
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
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                CompoundSolverView()
                    .navigationTitle(Text("Compound Solver"))
            }
            .tabItem {
                Text("Compound")
                Image(systemName:"waveform.path.ecg.rectangle")
            }.tag(0)
            NavigationView {
                DoubleView()
                    .navigationTitle(Text("Doubling"))
            }
            .tabItem {
                Text("Doubling Calculator")
                Image(systemName:"waveform.path.ecg.rectangle")
            }.tag(1)
            NavigationView {
                MenuView()
                    .navigationTitle(Text("Settings"))
            }
            .tabItem {
                Text("Settings")
                Image(systemName:"waveform.path.ecg.rectangle")
            }.tag(1)
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
