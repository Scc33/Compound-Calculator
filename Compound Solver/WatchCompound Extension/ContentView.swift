//
//  ContentView.swift
//  WatchCompound Extension
//
//  Created by Sean Coughlin on 8/3/21.
//

import SwiftUI
import SwiftUI_Apple_Watch_Decimal_Pad

struct ContentView: View {
    @State public var presentingModal: Bool = true
    private var placeholder = "0"
    @State private var text = "text"
    
    var body: some View {
        DigiTextView(placeholder: placeholder,
                     text: $text,
                     presentingModal: presentingModal,
                     alignment: .leading,
                     style: .decimal
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
