//
//  SwiftUIView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/24/22.
//

import SwiftUI

struct simpleView: View {
    var compound: CompoundCalculationModel
    
    var vals: [Double] {
        return compound.calcYearlyVals()
    }
    
    var body: some View {
        Section {
            Text("Initial: \(compound.currency.rawValue)\(stringify(value: vals[0]))")
                .contextMenu {
                    Button(action: {
                        UIPasteboard.general.string = String(vals[0])
                    }) {
                        Text("Copy initial value")
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
    }
}

struct complexView: View {
    var compound: CompoundCalculationModel
    
    var vals: [Double] {
        return compound.calcYearlyVals()
    }
    
    var contribs: [Double] {
        return compound.calcYearlyContrib()
    }
    
    var profits: [Double] {
        return compound.calcYearlyProfit()
    }
    
    var body: some View {
        Section {
            GeometryReader { metrics in
                HStack {
                    Spacer()
                    Text("Total").frame(width: metrics.size.width * 0.3)
                    Text("Contribution")
                    Text("Profit")
                }
                HStack {
                    Text("Initial:")
                    Spacer()
                    Text("\(compound.currency.rawValue)\(stringify(value: vals[0]))")
                    Spacer()
                    Text("\(compound.currency.rawValue)\(stringify(value: contribs[0]))")
                    Spacer()
                    Text("\(compound.currency.rawValue)\(stringify(value: profits[0]))")
                }
                .contextMenu {
                    Button(action: {
                        UIPasteboard.general.string = "profit: " + String(profits[0]) + ", contribution: " + String(contribs[0]) + ", profits: " + String(profits[0])
                    }) {
                        Text("Copy initial values")
                    }
                }
                ForEach(1 ..< vals.count) { i in
                    HStack {
                        Text("Year \(i):")
                        Spacer()
                        Text("\(compound.currency.rawValue)\(stringify(value: vals[i]))")
                        Spacer()
                        Text("\(compound.currency.rawValue)\(stringify(value: contribs[i]))")
                        Spacer()
                        Text("\(compound.currency.rawValue)\(stringify(value: profits[i]))")
                    }
                    .contextMenu {
                        Button(action: {
                            UIPasteboard.general.string = "profit: " + String(profits[i]) + ", contribution: " + String(contribs[i]) + ", profits: " + String(profits[i])
                        }) {
                            Text("Copy year \(i) values")
                        }
                    }
                }
            }
        }
    }
}

struct YearlyValuesView: View {
    @State private var complex = false
    var compound: CompoundCalculationModel
    
    var body: some View {
        return List {
            Section {
                Toggle(isOn: $complex) {
                    Text("Show complex view")
                }
            }
            if complex {
                complexView(compound: compound)
            } else {
                simpleView(compound: compound)
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
