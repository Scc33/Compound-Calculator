//
//  SwiftUIView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/24/22.
//

import SwiftUI

struct YearlyValuesView: View {
    var rate: String
    var initial: String
    var time: String
    var contributionAmt: String
    var compounding: compoundType
    
    var vals: [Double] {
        return calcYearlyVals(rate: rate, initial: initial, time: time, contributionAmt: contributionAmt, compounding: compounding)
    }
    
    var body: some View {
        return List {
            ForEach(0..<vals.count) { i in
                Text("Year \(i+1) - $\(String(format: "%.2f", vals[i]))")
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        YearlyValuesView(rate: "5", initial: "5", time: "3", contributionAmt: "2", compounding: .day)
    }
}
