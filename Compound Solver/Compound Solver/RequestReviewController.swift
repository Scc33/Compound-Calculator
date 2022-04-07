//
//  RequestReviewController.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 2/9/22.
//

import Foundation

struct RequestReviewController: Codable {
    public var countCalcs: Int
                
    init() {
        if let data = UserDefaults.standard.data(forKey: "countCalcs") {
            if let decoded = try? JSONDecoder().decode(Int.self, from: data) {
                    countCalcs = decoded
                    return
                }
            }
        
        countCalcs = 0
    }
    
    mutating func checkForReviewRequest() -> Bool {
        countCalcs += 1
        
        if let encoded = try? JSONEncoder().encode(self.countCalcs) {
            UserDefaults.standard.set(encoded, forKey: "countCalcs")
        }
        
        return (countCalcs == 10 || countCalcs % 50 == 0) && countCalcs != 0
    }
}
