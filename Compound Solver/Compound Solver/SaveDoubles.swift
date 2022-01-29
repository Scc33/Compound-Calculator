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
    }
}
