//
//  SimpleInterestView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 2/8/22.
//

import SwiftUI
import Combine

struct SimpleInterestView: View {
    @State private var showingSettings = false
    @State private var stringInterest = ""
    @State private var principal = ""
    @State private var setTime = 0
    //@State private var savedSimple = SaveSimple()

    var body: some View {
        Form {
            VStack(alignment: .leading) {
                Text("Interest Rate")
                HStack {
                    Text("%")
                    TextField("Rate", text: $stringInterest)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .onReceive(Just(stringInterest)) { newValue in
                            let filtered = newValue.filter { "0123456789.".contains($0) }
                            if filtered != newValue {
                                stringInterest = filtered
                            }
                        }
                }
            }
            VStack(alignment: .leading) {
                Text("Principal")
                HStack {
                    Text("$")
                    TextField("Amount", text: $principal)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .onReceive(Just(principal)) { newValue in
                            let filtered = newValue.filter { "0123456789.".contains($0) }
                            if filtered != newValue {
                                stringInterest = filtered
                            }
                        }
                }
            }
            VStack(alignment: .leading) {
                Text("Years of Growth")
                Picker("", selection: $setTime) {
                    ForEach(1...100, id: \.self) {
                        Text("\($0)")
                    }
                }
            }
            Button("Calculate") {
                /*if let encoded = try? JSONEncoder().encode(savedSimple.history) {
                    UserDefaults.standard.set(encoded, forKey: "SavedSimple")
                }*/
                
            }
        }
        .toolbar {
            Button {
                self.showingSettings.toggle()
            } label: {
                Image(systemName: "questionmark.circle")
            }
        }.sheet(isPresented: $showingSettings) {
            SettingMenuView()
        }
        .navigationTitle(Text("Simple Interest"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SimpleInterestView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleInterestView()
    }
}
