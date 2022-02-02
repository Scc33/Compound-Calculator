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
        return compound.calcYearlyVals()
    }
    
    var body: some View {
        return List {
            Text("Initial Principal: \(compound.currency.rawValue)\(stringify(value: vals[0]))")
                .contextMenu {
                    Button(action: {
                        UIPasteboard.general.string = String(vals[0])
                    }) {
                        Text("Copy")
                    }
                }
            ForEach(1..<vals.count) { i in
                Text("Year \(i): \(compound.currency.rawValue)\(stringify(value: vals[i]))")
                    .contextMenu {
                        Button(action: {
                            UIPasteboard.general.string = String(vals[i])
                        }) {
                            Text("Copy year \(i) value")
                        }
                    }
            }
        }
        .navigationTitle(Text("Yearly Values"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        YearlyValuesView(compound: CompoundCalculationModel())
    }
}
