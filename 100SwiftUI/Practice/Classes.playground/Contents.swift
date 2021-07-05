import UIKit

var greeting = "Hello, playground"

class Dog {
    func makeNoise() {
        print("Woof!")
    }
}

class Poodle: Dog {
    override func makeNoise() {
        print("Yip!")
    }
}

let gus = Dog()
let cal = Poodle()
gus.makeNoise()
cal.makeNoise()

//Final means no class can inherit from it
//Using final is usually a good idea unless you specifically wanted a class to be extensible
//Classes use references so data is shared

//Classes can have deinitializers that are run when the class instance is deleted --deinit
//Often used to say when a class is destroyed
//Behind the scense Swift ues ARC - automatic reference counting, when the count of references to the underlying data reaches zero the data is deleted

class Person {
    var name = "John Doe"

    init() {
        print("\(name) is alive!")
    }

    func printGreeting() {
        print("Hello, I'm \(name)")
    }
    
    deinit {
        print("\(name) is no more!")
    }
}

for _ in 1...3 {
    let person = Person()
    person.printGreeting()
}


//Mutatability
class Singer {
    var name = "Taylor Swift"
}

//The taylor is a constant (reference) so the underlying data is still changable
let taylor = Singer()
taylor.name = "Ed Sheeran"
print(taylor.name)
