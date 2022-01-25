//
//  SaveCompounds.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/24/22.
//

import Foundation

struct SaveCompounds: Codable {
    var savedCompounds: [CompoundCalculationModel] = []

    mutating func save(compoundToSave: CompoundCalculationModel) {
        savedCompounds.append(compoundToSave)
    }
}
