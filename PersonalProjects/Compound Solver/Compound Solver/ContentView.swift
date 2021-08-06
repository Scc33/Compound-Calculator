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
    
    // TODO
    // Maybe factor this code out into its own struct/function so it can be called easily from other structs
    var vals: [Double] {
        let cRate = Double(rate) ?? 0
        let cInitial = Double(initial) ?? 0
        let cTime = Int(time) ?? 0
        let cContributionAmt = Double(contributionAmt) ?? 0
        let cNumberContrib = Double(numberContrib) ?? 0
        
        var calcVals = [cInitial]
        
        for _ in 0 ..< cTime {
            var currVal = calcVals[calcVals.endIndex - 1]
            currVal += (cContributionAmt * cNumberContrib)
            currVal = currVal * pow((1 + (cRate / cNumberContrib)), cNumberContrib)
            calcVals.append(currVal)
        }
        
        return calcVals
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

struct CompoundSolverView: View {
    @State private var rate = ""
    @State private var initial = ""
    @State private var time = ""
    @State private var contributionAmt = ""
    @State private var numberContrib = ""
    @State private var compounding: compoundType = .day
    @State private var graphing: graphType = .bar
    @State private var showContrib = false
    
    var body: some View {
        Form {
            Section {
                TextField("Rate", text: $rate)
                    .keyboardType(.decimalPad)
                HStack {
                    TextField("Contribution amount", text: $contributionAmt)
                        .keyboardType(.decimalPad)
                    TextField("Years", text: $time)
                        .keyboardType(.decimalPad)
                }
                HStack {
                    TextField("Contributions per Year", text: $numberContrib)
                    TextField("Initial amount", text: $initial)
                        .keyboardType(.decimalPad)
                }
                Picker("Base", selection: $compounding) {
                    ForEach(compoundType.allCases, id: \.id) { value in
                        Text(value.localizedName)
                            .tag(value)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            Section {
                Text("Final Value") // currently this could call YearlyValues but that feels obtuse
                // needs its own function to call somehow
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
                Text("Graph")
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
