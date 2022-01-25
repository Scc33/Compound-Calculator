//
//  HistoryView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/24/22.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var currCompound: CompoundCalculationModel
    var History: SaveCompounds
    @Binding var rootIsActive: Bool
    
    var body: some View {
        List {
            ForEach(History.savedCompounds) { compound in
                Button(action: {}) {
                    Text("Button")
                       .frame(maxWidth: .infinity, maxHeight: .infinity)
                       .contentShape(Rectangle())
                }
                .buttonStyle(PlainButtonStyle()) 
                Button(action: {
                    currCompound.rate = compound.rate
                    currCompound.initial = compound.initial
                    currCompound.time = compound.time
                    currCompound.contributionAmt = compound.contributionAmt
                    currCompound.compounding = compound.compounding
                    self.rootIsActive = false
                }) {
                    VStack(alignment: .leading) {
                        Text("Interest rate \(compound.rate)")
                        Text("Initial principal \(compound.initial)")
                        Text("Years of growth \(compound.time)")
                        Text("Monthly contribution \(compound.contributionAmt)")
                        Text("Compounding \(compound.compounding.rawValue)")
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .navigationTitle(Text("Yearly Values"))
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(currCompound: CompoundCalculationModel(), History: SaveCompounds(), rootIsActive: .constant(false))
    }
}
