import UIKit

var greeting = "Hello, playground"

//Computed properties
struct Person {
    var age: Int

    var ageInDogYears: Int {
        get {
            return age * 7
        }
    }
}

var fan = Person(age: 25)
print(fan.ageInDogYears)

//Static
struct TaylorFan {
    static var favoriteSong = "Look What You Made Me Do"

    var name: String
    var age: Int
}

let fan2 = TaylorFan(name: "James", age: 25)
print(TaylorFan.favoriteSong)
//static methods belong to the struct itself rather than to instances of that struct, so you can't use it to access any non-static properties from the struct.

//TODO: type conversion
//TODO: more closures
