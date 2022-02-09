//
//  File.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 2/9/22.
//

import Foundation

struct SimpleInterest: Identifiable, Codable {
    var id = UUID()
    var interest: Double
    var principal: Double
    var time: Double
    
    func calcInterest() -> 
}

class SaveSimple: Codable, ObservableObject {
    var savedSimple: [SimpleInterest]
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "SavedSimple") {
                if let decoded = try? JSONDecoder().decode([SimpleInterest].self, from: data) {
                    savedSimple = decoded
                    return
                }
            }
        
        savedSimple = []
    }
    
    func delete(at offsets: IndexSet) {
        savedSimple.remove(atOffsets: offsets)
        if let encoded = try? JSONEncoder().encode(savedSimple) {
            UserDefaults.standard.set(encoded, forKey: "SavedSimple")
        }
    }

    func save(simpleToSave: SimpleInterest) {
        savedSimple.append(simpleToSave)
        if (savedSimple.count > 10) {
            savedSimple.remove(at: 0)
        }
        if let encoded = try? JSONEncoder().encode(savedSimple) {
            UserDefaults.standard.set(encoded, forKey: "SavedSimple")
        }
    }
}
