//
//  SwiftUIView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/24/22.
//

import SwiftUI

struct YearlyValuesView: View {
    var compound: CompoundCalculationModel
    
    var vals: [Double] {
        return compound.calcYearlyVals
    }
    
    var body: some View {
        return List {
            ForEach(0..<vals.count) { i in
                Text("Year \(i+1) - \(compound.currency.rawValue)\(String(format: "%.2f", vals[i]))")
            }
        }
        .navigationTitle(Text("Yearly Values"))
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        YearlyValuesView(compound: CompoundCalculationModel())
    }
}
