//
//  DoubleView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/24/22.
//

// The rule of 72
// https://en.wikipedia.org/wiki/Rule_of_72#E-M_rule
// maybe include a link to this and the formulas under the settings

import SwiftUI

/*enum topLine: String, Equatable, CaseIterable, Identifiable {
 case exact = "69.3"
 case seventy = "70"
 case seventyTwo = "72"
 
 var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
 var id: String { self.rawValue }
 }*/


struct DoubleView: View {
    //@State private var estBase: topLine = .seventy
    @State private var interest = 0.0
    @State private var showTime = false
    @State private var time = 0.0
    @State private var saveDoubles = SaveDoubles()
    @State var isActive: Bool = false
    
    func createTime() {
        if showTime == false {
            showTime = true
        }
    }
    
    let formatterDecimal: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    func excDouble() -> Double {
        let num = log(2.0)
        let dem = log(1.0 + (interest / 100.0))
        return num / dem
    }
    
    /*var estDouble: Double {
     let convertedEstBase = Double(estBase.id) ?? 0.1
     let convertedEstInterest = Double(estInterest) ?? 0.1
     return convertedEstBase / convertedEstInterest
     }*/
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack(alignment: .leading) {
                        Text("Interest Rate")
                        HStack {
                            Text("%")
                            TextField("", value: $interest, formatter: formatterDecimal)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    Button("Calculate") {
                        saveDoubles.save(doubleToSave: interest)
                        hideKeyboard()
                        createTime()
                        time = excDouble()
                    }
                    /*VStack(alignment: .leading) {
                     Text("Rule of 72/70/69.3")
                     Picker("", selection: $estBase) {
                     ForEach(topLine.allCases, id: \.id) { value in
                     Text(value.localizedName)
                     .tag(value)
                     }.pickerStyle(SegmentedPickerStyle())
                     }
                     }*/
                }
                if showTime {
                    Section {
                        //Text("Estimated doubling time \(String(format:"%.2f",estDouble)) years")
                        Text("Doubling time \(String(format:"%.2f",time)) years")
                            .contextMenu {
                                Button(action: {
                                    UIPasteboard.general.string = String(time)
                                }) {
                                    Text("Copy")
                                }
                            }
                    }
                }
                if showTime {
                    Section {
                        NavigationLink(destination: DoubleHistoryView(interest: $interest, history: saveDoubles, rootIsActive: $isActive, showTime: $showTime), isActive: $isActive) {
                            Text("History")
                        }
                        .isDetailLink(false)
                    }
                }
            }
            .navigationTitle(Text("Doubling Calculator"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct DoubleView_Previews: PreviewProvider {
    static var previews: some View {
        DoubleView()
    }
}
