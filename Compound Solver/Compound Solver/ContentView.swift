//
//  ContentView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 8/1/21.
//  Updated started on 1/24/22.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CompoundSolverView()
                .tabItem {
                    Text("Compound")
                    Image(systemName:"align.vertical.bottom.fill")
                }.tag(0)
            DoubleView()
                .tabItem {
                    Text("Doubling Calculator")
                    Image(systemName:"multiply")
                }.tag(1)
            FormulaView()
                .tabItem {
                    Text("Formula")
                    Image(systemName:"function")
                }.tag(2)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
