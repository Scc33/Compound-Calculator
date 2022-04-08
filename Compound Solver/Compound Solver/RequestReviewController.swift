//
//  RequestReviewController.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 2/9/22.
//

import Foundation

class RequestReviewController: Codable, ObservableObject {
    public var countCalcs: Int
                
    init() {
        if let data = UserDefaults.standard.data(forKey: "countCalc") {
            if let decoded = try? JSONDecoder().decode(Int.self, from: data) {
                    countCalcs = decoded
                    return
                }
            }
        
        countCalcs = 0
    }
    
    func checkForReviewRequest() -> Bool {
        countCalcs += 1
        print(countCalcs)
        
        if let encoded = try? JSONEncoder().encode(self.countCalcs) {
            UserDefaults.standard.set(encoded, forKey: "countCalc")
        }
        
        return countCalcs % 10 == 0 && countCalcs != 0
    }
}
