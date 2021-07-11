import UIKit

var greeting = "Hello, playground"

// var name //Type annotation missing pattern
var name: String

//Official Apple documentation recommends always using Double
var latitude: Double
latitude = 36.166667

//Possible but String can be omitted because of type inference
var name2: String = "Tim McGraw"

//Limited percision
var longitude: Float
longitude = -86.783333
longitude = -186.783333
longitude = -1286.783333
longitude = -12386.783333
longitude = -123486.783333
longitude = -1234586.783333

//String interpolation (more powerful than concatonation)
var age = 25
print("You are \(age) years old. In another \(age) years you will be \(age * 2).")

var songs = ["Shake it Off", "You Belong with Me", "Back to December"]
type(of: songs)

//Special kind of array that is forced to story any type of data
var songs2: [Any] = ["Shake it Off", "You Belong with Me", "Back to December", 3]

//Dictionaries
var person = [
                "first": "Taylor",
                "middle": "Alison",
                "last": "Swift",
                "month": "December",
                "website": "taylorswift.com"
            ]

person["middle"]
person["month"]

for i in 1...10 {
    print("\(i) x 10 is \(i * 10)")
}

var songs3 = ["Shake it Off", "You Belong with Me", "Look What You Made Me Do"]

for song in songs3 {
    print("My favorite song is \(song)")
}

let liveAlbums = 0

switch liveAlbums {
    case 0:
        print("You're just starting out")
    default:
        print("Have you done something new?")
}
