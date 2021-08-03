//
//  ContentView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 8/1/21.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State private var selectedTab = 1
    @State private var isShareSheetShowing = false
    
    @State private var initial = ""
    @State private var contributions = ""
    @State private var time = ""
    
    @State private var estBase: topLine = .seventy
    @State private var estInterest = ""
    
    func shareButton() {
        isShareSheetShowing.toggle()
        let url = URL(string: "https://apple.com")
        let activityView = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
    }
    
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
        VStack {
            TabView(selection: $selectedTab) {
                NavigationView {
                    VStack(alignment: .center) {
                        HStack {
                            Spacer()
                            Button(action: shareButton) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.largeTitle)
                            }
                            Image(systemName:  "gearshape")
                                .font(.largeTitle)
                        }
                        Form {
                            Section {
                                TextField("Initial", text: $initial)
                                    .keyboardType(.decimalPad)
                                TextField("Contributions", text: $contributions)
                                    .keyboardType(.decimalPad)
                                TextField("Years", text: $time)
                                    .keyboardType(.decimalPad)
                            }
                            Section {
                                Text("test")
                                Text("test1")
                            }
                        }
                    }
                    .navigationTitle(Text("Title"))
                }
                .tabItem {
                    Text("Graph")
                    Image(systemName:"waveform.path.ecg.rectangle")
                }.tag(0)
                VStack {
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
                .tabItem {
                    Text("Rule of 72")
                    Image(systemName:"waveform.path.ecg.rectangle")
                }.tag(1)
            }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
