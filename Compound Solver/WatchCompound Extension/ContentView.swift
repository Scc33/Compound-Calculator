//
//  ContentView.swift
//  WatchCompound Extension
//
//  Created by Sean Coughlin on 8/3/21.
//

import SwiftUI
import SwiftUI_Apple_Watch_Decimal_Pad

enum calculateType: String, Equatable, CaseIterable, Identifiable, Codable {
    case double = "double"
    case compound = "compound"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
    var id: String { self.rawValue }
}

struct CalculateView: View {
    @State public var presentingModal: Bool = false
    @State private var placeholder = ""
    @State private var stringInterest = ""
    let type: calculateType
    
    func excDouble() -> Double {
        let interest = Double(stringInterest) ?? 0.0
        let num = log(2.0)
        let dem = log(1.0 + (interest / 100.0))
        return num / dem
    }
    
    var compoundView: some View {
        Text("Compound View")
    }
    
    var doubleView: some View {
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
    
    var body: some View {
        if type == calculateType.compound {
            compoundView
        } else {
            doubleView
        }
    }
}

struct RowView: View {
    let title: String
    let image: String
    let type: calculateType
    
    var body: some View {
        NavigationLink(destination: CalculateView(type: type)) {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: image)
                    .resizable()
                    .frame(width: 32.0, height: 32.0)
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        List{
            RowView(title: "Compound Solver", image: "align.vertical.bottom.fill", type: calculateType.compound)
            RowView(title: "Double Calculator", image: "multiply", type: calculateType.double)
        }
        .listStyle(.carousel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
