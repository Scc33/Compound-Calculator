//
//  OtherCalcView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 2/8/22.
//

import SwiftUI

struct OtherCalcMenuView: View {
    @State private var showingSettings = false

    var body: some View {
        NavigationView {
            List {
                /*NavigationLink(destination: CompoundTargetView()) {
                    Text("Compound Target Calculator")
                }*/
                NavigationLink(destination: AnnualRateOfReturnView()) {
                    Text("Annual Rate of Return")
                }
                NavigationLink(destination: DebtCalcView()) {
                    Text("Debt Calculator")
                }
                NavigationLink(destination: DoubleView()) {
                    Text("Doubling Calculator")
                }
                NavigationLink(destination: PercentageGrowthView()) {
                    Text("Percent Growth Calculator")
                }
                NavigationLink(destination: SimpleInterestView()) {
                    Text("Simple Interest Calculator")
                }
            }
            .navigationTitle(Text("Other Calculators"))
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

struct OtherCalcMenuView_Previews: PreviewProvider {
    static var previews: some View {
        OtherCalcMenuView()
    }
}
