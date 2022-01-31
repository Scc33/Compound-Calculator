//
//  DoubleHistory.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/29/22.
//

import Foundation

class SaveDoubles: Codable, ObservableObject {
    var savedDoubles: [Double]
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "SavedDouble") {
                if let decoded = try? JSONDecoder().decode([Double].self, from: data) {
                    savedDoubles = decoded
                    return
                }
            }
        
        savedDoubles = []
    }
    
    func delete(at offsets: IndexSet) {
        savedDoubles.remove(atOffsets: offsets)
        if let encoded = try? JSONEncoder().encode(savedDoubles) {
            UserDefaults.standard.set(encoded, forKey: "SavedDouble")
        }
    }

    func save(doubleToSave: Double) {
        savedDoubles.append(doubleToSave)
        if (savedDoubles.count > 10) {
            savedDoubles.remove(at: 0)
        }
        if let encoded = try? JSONEncoder().encode(savedDoubles) {
            UserDefaults.standard.set(encoded, forKey: "SavedDouble")
        }
    }
}
