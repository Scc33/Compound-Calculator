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
    var rate: Double
    var initial: Double
    var time: Int
    var contributionAmt: Double
    var compounding: compoundType
    var currency: currencyType
    
    init() {
        rate = 0.0
        initial = 0.0
        time = 0
        contributionAmt = 0.0
        compounding = compoundType.day
        currency = currencyType.dollar
    }
    
    init(rate: Double, initial: Double, time: Int, contributionAmt: Double, compounding: compoundType, currency: currencyType) {
        self.rate = rate
        self.initial = initial
        self.time = time
        self.contributionAmt = contributionAmt
        self.compounding = compounding
        self.currency = currency
    }
    
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
    
    func calcContrib() -> Double {
        return initial + ((contributionAmt * 12) * Double(time))
    }
    
    func calcProfit() -> Double {
        return (calcYearlyVals().last ?? 0.0) - calcContrib()
    }
    
    func graphYearlyVals() -> [Double] {
        var graphVals = calcYearlyVals()
        for i in 0 ..< graphVals.count {
            graphVals[i] /= (graphVals.last ?? 1)
        }
        return graphVals
    }
}
