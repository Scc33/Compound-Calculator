//
//  SaveCompounds.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/24/22.
//

import Foundation

class SaveCompounds: Codable, ObservableObject {
    var savedCompounds: [CompoundCalculationModel] = []

    func save(compoundToSave: CompoundCalculationModel) {
        savedCompounds.append(compoundToSave)
    }
}
