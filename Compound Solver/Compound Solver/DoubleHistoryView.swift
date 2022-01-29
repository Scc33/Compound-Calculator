//
//  DoubleHistoryView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/29/22.
//

import SwiftUI

struct DoubleHistoryView: View {
    @Binding var interest: Double
    var history: SaveDoubles
    @Binding var rootIsActive: Bool
    @Binding var showTime: Bool
    
    var body: some View {
        List {
            ForEach(0..<history.savedDoubles.count) { i in
                Button(action: {
                    interest = history.savedDoubles[i]
                    showTime = false
                    rootIsActive = false
                }) {
                    VStack(alignment: .leading) {
                        Text("Interest rate - \(String(format: "%.2f", history.savedDoubles[i]))%")
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .navigationTitle(Text("History"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DoubleHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        DoubleHistoryView(interest: .constant(0.0), history: SaveDoubles(), rootIsActive: .constant(false), showTime: .constant(false))
    }
}
