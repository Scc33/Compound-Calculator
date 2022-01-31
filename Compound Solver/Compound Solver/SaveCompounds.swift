//
//  SaveCompounds.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/24/22.
//

import Foundation

class SaveCompounds: Codable, ObservableObject {
    var savedCompounds: [CompoundCalculationModel]

    init() {
        if let data = UserDefaults.standard.data(forKey: "SavedCompound") {
                if let decoded = try? JSONDecoder().decode([CompoundCalculationModel].self, from: data) {
                    savedCompounds = decoded
                    return
                }
            }
        
        savedCompounds = []
    }
    
    func delete(at offsets: IndexSet) {
        savedCompounds.remove(atOffsets: offsets)
        if let encoded = try? JSONEncoder().encode(savedCompounds) {
            UserDefaults.standard.set(encoded, forKey: "SavedCompound")
        }
    }
    
    func save(compoundToSave: CompoundCalculationModel) {
        let newCompound = CompoundCalculationModel(rate: compoundToSave.rate, initial: compoundToSave.initial, time: compoundToSave.time, contributionAmt: compoundToSave.contributionAmt, compounding: compoundToSave.compounding, currency: compoundToSave.currency)
        savedCompounds.append(newCompound)
        if (savedCompounds.count > 10) {
            savedCompounds.remove(at: 0)
        }
        if let encoded = try? JSONEncoder().encode(savedCompounds) {
            UserDefaults.standard.set(encoded, forKey: "SavedCompound")
        }
    }
}
