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

func calcYearlyVals(rate: String, initial: String, time: String, contributionAmt: String, compounding: compoundType) -> [Double] {
    let cRate = (Double(rate) ?? 0) / 100
    let cInitial = Double(initial) ?? 0
    let cTime = Int(time) ?? 0
    let cContributionAmt = Double(contributionAmt) ?? 0
    var numberCompound = 1.0;
    switch compounding {
    case .day : numberCompound = 365.0
    case .week : numberCompound = 52.0
    case .month : numberCompound = 12.0
    case .quarter : numberCompound = 4.0
    default : numberCompound = 1.0
    }
    
    var calcVals = [cInitial]
    
    for _ in 0 ..< cTime {
        var currVal = calcVals.last ?? 0
        currVal += (cContributionAmt * 12)
        currVal = currVal * pow((1 + (cRate / numberCompound)), numberCompound)
        calcVals.append(currVal)
    }
    
    return calcVals
}

struct YearlyValues: View {
    var rate: String
    var initial: String
    var time: String
    var contributionAmt: String
    var compounding: compoundType
    
    var vals: [Double] {
        return calcYearlyVals(rate: rate, initial: initial, time: time, contributionAmt: contributionAmt, compounding: compounding)
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

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CompoundSolverView()
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
