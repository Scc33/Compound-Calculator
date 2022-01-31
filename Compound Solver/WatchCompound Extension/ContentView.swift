//
//  ContentView.swift
//  WatchCompound Extension
//
//  Created by Sean Coughlin on 8/3/21.
//

import SwiftUI
import SwiftUI_Apple_Watch_Decimal_Pad

struct ContentView: View {
    @State public var presentingModal: Bool = false
    private var placeholder = ""
    @State private var stringInterest = ""
    
    func excDouble() -> Double {
        let interest = Double(stringInterest) ?? 0.0
        let num = log(2.0)
        let dem = log(1.0 + (interest / 100.0))
        return num / dem
    }
    
    var body: some View {
        VStack {
            if (stringInterest == "") {
                Text("Enter an interest rate")
            } else {
                Text("Doubling time \(String(format:"%.2f",excDouble())) years")
            }
            DigiTextView(placeholder: placeholder,
                         text: $stringInterest,
                         presentingModal: presentingModal,
                         alignment: .leading,
                         style: .decimal
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
