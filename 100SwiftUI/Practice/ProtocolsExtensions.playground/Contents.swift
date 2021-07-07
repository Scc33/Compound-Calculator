import UIKit

var greeting = "Hello, playground"

//"Protocols are a way of describing what properties and methods something must have"
//protocols let us create blueprints of how our types share functionality

protocol Identifiable {
    var id: String { get set }
}

struct User: Identifiable {
    var id: String
}

func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}

var s = User(id: "1234")
displayID(thing: s)

//protocols determine the minimum required functionality, but we can always add more

protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}

protocol Employee: Payable, NeedsTraining, HasVacation { }

//Extensions allow for adding properties to types
//Has to be a computed property, cannot be stored

extension Int {
    func squared() -> Int {
        return self * self
    }
}

let number = 8
number.squared()

let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])

//Arrays in Swift conform to collection protocol, protocols can be expanded using collections
//"protocol-oriented programming language"

extension Collection {
    func summarize() {
        print("There are \(count) of us:")

        for name in self {
            print(name)
        }
    }
}

pythons.summarize()
beatles.summarize()

//POP is a new concept than OOP
