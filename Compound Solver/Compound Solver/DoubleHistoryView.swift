//
//  DoubleHistoryView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/29/22.
//

import SwiftUI

struct DoubleHistoryView: View {
    @Binding var interest: Double
    @State var history: SaveDoubles
    @Binding var rootIsActive: Bool
    @Binding var showTime: Bool
    @State private var showingSettings = false
    
    @Binding var stringInterest: String
    
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        List {
            ForEach(history.savedDoubles, id: \.self) { doub in
                Button(action: {
                    interest = doub
                    showTime = false
                    rootIsActive = false
                    stringInterest = String(interest)
                }) {
                    VStack(alignment: .leading) {
                        Text("Interest rate - \(String(format: "%.2f", doub))%")
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
              history = SaveDoubles.init()
          }
        })
        .navigationTitle(Text("History"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DoubleHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        DoubleHistoryView(interest: .constant(0.0), history: SaveDoubles(), rootIsActive: .constant(false), showTime: .constant(false), stringInterest: .constant(""))
    }
}
