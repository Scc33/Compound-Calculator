import UIKit

var greeting = "Hello, playground"

//optionals

var age: Int? = nil
age = 38

//Example use of optionals: find number 5 in array [...] well 5 may or may not be in that array

//Unwrapping
var name: String? = nil
if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name.")
}
//"single most important feature of optionals is that Swift won’t let us use them without unwrapping them first"

//guard let functionals similarly to if let
func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }

    print("Hello, \(unwrapped)!")
}
//"So, use if let if you just want to unwrap some optionals, but prefer guard let if you’re specifically checking that conditions are correct before continuing."

//Force unwrapping
let str = "5"
let num = Int(str)!

//Implicitly unwrapped optional
let age2: Int! = nil
//Implicity unwrapped optionals have become rarer as Swift gets more mature

//Nil coalescing
func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}
let user = username(for: 15) ?? "Anonymous"

