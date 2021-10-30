//
//  Todo.swift
//  MyToDos
//
//  Created by Sean Coughlin on 10/29/21.
//

import Foundation

struct ToDo: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var completed: Bool = false
    
    static var sampleData: [ToDo] {
        [
            ToDo(name: "Get Groceries"),
            ToDo(name: "Code")
        ]
    }
}
