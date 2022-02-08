//
//  OtherCalcView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 2/8/22.
//

import SwiftUI

struct OtherCalcView: View {
    @State private var showingSettings = false

    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: DoubleView()) {
                    Text("Doubling Calculator")
                }
                NavigationLink(destination: SimpleInterestView()) {
                    Text("Simple Interest Calculator")
                }
            }
            .navigationTitle(Text("Other Calculator"))
            .toolbar {
                Button {
                    self.showingSettings.toggle()
                } label: {
                    Image(systemName: "gear")
                }
            }.sheet(isPresented: $showingSettings) {
                SettingMenuView()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct OtherCalcView_Previews: PreviewProvider {
    static var previews: some View {
        OtherCalcView()
    }
}
