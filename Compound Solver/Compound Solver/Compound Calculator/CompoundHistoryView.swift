//
//  HistoryView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/24/22.
//

import SwiftUI

struct CompoundHistoryView: View {
    @Binding var currCompound: CompoundCalculationModel
    @State var history: SaveCompounds
    @Binding var rootIsActive: Bool
    @Binding var calculated: Bool
    
    @Binding var rate: String
    @Binding var initial: String
    @Binding var contributionAmt: String
    @Binding var setTime: Int
    
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        List {
            ForEach(history.savedCompounds) { compound in
                Button(action: {
                    currCompound.rate = compound.rate
                    currCompound.initial = compound.initial
                    currCompound.time = compound.time
                    currCompound.contributionAmt = compound.contributionAmt
                    currCompound.compounding = compound.compounding
                    rootIsActive = false
                    calculated = false
                    rate = String(compound.rate)
                    initial = String(compound.initial)
                    contributionAmt = String(compound.contributionAmt)
                    setTime = compound.time
                }) {
                    VStack(alignment: .leading) {
                        Text("Interest rate: \(String(format: "%.2f", compound.rate))%")
                        Text("Initial principal: \(compound.currency.rawValue)\(String(format: "%.2f", compound.initial))")
                        Text("Years of growth: \(compound.time)")
                        Text("Monthly contribution: \(compound.currency.rawValue)\(String(format: "%.2f", compound.contributionAmt))")
                        Text("Compounding: \(compound.compounding.rawValue)")
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .onDelete(perform: history.delete)
        }
        .toolbar {
            EditButton()
        }
        .onChange(of: editMode!.wrappedValue, perform: { value in
            if value.isEditing {
                // Entering edit mode (e.g. 'Edit' tapped)
            } else {
                // Leaving edit mode (e.g. 'Done' tapped)
                history = SaveCompounds.init()
            }
        })
        .navigationTitle(Text("History"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CompoundHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        CompoundHistoryView(currCompound: .constant(CompoundCalculationModel()), history: SaveCompounds(), rootIsActive: .constant(false), calculated: .constant(false), rate: .constant(""), initial: .constant(""), contributionAmt: .constant(""), setTime: .constant(0))
    }
}
