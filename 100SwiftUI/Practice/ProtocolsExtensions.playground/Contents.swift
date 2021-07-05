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
