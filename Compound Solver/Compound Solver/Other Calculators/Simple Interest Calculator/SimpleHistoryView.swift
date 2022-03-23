//
//  SimpleHistoryView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 2/9/22.
//

import SwiftUI

struct SimpleHistoryView: View {
    @Binding var interest: Double
    @State var history: SaveSimple
    @Binding var rootIsActive: Bool
    @Binding var showTime: Bool
    
    @Binding var stringInterest: String
    
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        List {
            ForEach(history, id: \.self) { simp in
                Button(action: {
                    interest = simp
                    showTime = false
                    rootIsActive = false
                    stringInterest = String(interest)
                }) {
                    VStack(alignment: .leading) {
                        Text("Interest rate: \(String(format: "%.2f", simp))%")
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

struct SimpleHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleHistoryView(interest: .constant(0.0), history: .constant(SaveSimple()), rootIsActive: .constant(false), showTime: , stringInterest: <#T##String#>, editMode: <#T##arg#>, body: <#T##View#>)
    }
}
