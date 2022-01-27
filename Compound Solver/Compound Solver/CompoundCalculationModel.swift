//
//  CompoundCalculationModel.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/24/22.
//

import Foundation
import SwiftUI

struct CompoundCalculationModel: Identifiable, Codable {
    var id = UUID()
    var rate: Double = 0.0
    var initial: Double = 0.0
    var time: Int = 0
    var contributionAmt: Double = 0.0
    var compounding: compoundType = compoundType.day
    var currency: currencyType = currencyType.dollar
    
    /*init(rate: String, initial: String, time: String, contributionAmt: String, compounding: compoundType, currency: currencyType) {
     self.rate = rate
     self.initial = initial
     self.time = time
     self.contributionAmt = contributionAmt
     self.compounding = compounding
     self.currency = currency
     }*/
    
    func calcYearlyVals() -> [Double] {
        let cRate = rate / 100
        var numberCompound = 1.0;
        switch compounding {
        case .day : numberCompound = 365.0
        case .week : numberCompound = 52.0
        case .biWeekly : numberCompound = 26.0
        case .month : numberCompound = 12.0
        case .quarter : numberCompound = 4.0
        case .semiYearly : numberCompound = 2.0
        default : numberCompound = 1.0
        }
        
        var currVal = initial
        var calcVals = [initial]
        
        for _ in 0 ..< time {
            currVal += (contributionAmt * 12)
            currVal = currVal * pow((1 + (cRate / numberCompound)), numberCompound)
            let roundedVal = round(currVal * 100) / 100.0
            calcVals.append(roundedVal)
        }
        
        return calcVals
    }
    
    func graphYearlyVals() -> [Double] {
        var graphVals = calcYearlyVals()
        for i in 0 ..< graphVals.count {
            graphVals[i] /= (graphVals.last ?? 1)
        }
        return graphVals
    }
}
