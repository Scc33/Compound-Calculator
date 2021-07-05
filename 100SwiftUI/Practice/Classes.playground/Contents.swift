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
//Using final is usually a good idea unless you specifically wanted a class to
// be extensible
//Classes use references so data is shared
