//
//  FormulaView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/24/22.
//

import SwiftUI

struct FormulaView: View {
    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .leading) {
                    Text("Compound Interest")
                    Text("A = P (1 + r/n) ") + Text("nt").font(.system(.footnote)).baselineOffset(10)
                }
                VStack(alignment: .leading) {
                    Text("Future Value of a series")
                    Text("FV = PMT (1 + r/n) ") + Text("nt").font(.system(.footnote)).baselineOffset(10) + Text("-1 / (r/n)")
                }
            }
            .navigationTitle("Formula")
        }
    }
}

struct FormulaView_Previews: PreviewProvider {
    static var previews: some View {
        FormulaView()
    }
}
