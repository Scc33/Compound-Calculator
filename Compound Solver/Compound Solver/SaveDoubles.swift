//
//  DoubleHistory.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/29/22.
//

import Foundation

class SaveDoubles: Codable, ObservableObject {
    var savedDoubles: [Double] = []

    func save(doubleToSave: Double) {
        savedDoubles.append(doubleToSave)
        if (savedDoubles.count > 10) {
            savedDoubles.remove(at: 0)
        }
    }
}
