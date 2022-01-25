//
//  HistoryView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/24/22.
//

import SwiftUI

struct HistoryView: View {
    var History: SaveCompounds
    
    var body: some View {
        List {
            ForEach(History.savedCompounds) { compound in
                VStack {
                    Text(compound.rate)
                    Text(compound.initial)
                    Text(compound.time)
                    Text(compound.contributionAmt)
                    //Text.rawValue(compound.compounding)
                }
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(History: SaveCompounds())
    }
}
