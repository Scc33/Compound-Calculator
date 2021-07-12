import UIKit

var greeting = "Hello, playground"


// -> String means we will definitely return a string
// -> String? means we might or might not return something
//If let is used to unwrap a variable and check to see if there is something there
//! is used to for Swift to use a value

//?? - nil coalescin operator

//Enum - allows you to define a new datatype and say what type of data it can contain
enum WeatherType {
    case sun, cloud, rain, wind, snow
}

func getHaterStatus(weather: WeatherType) -> String? {
    if weather == WeatherType.sun {
        return nil
    } else {
        return "Hate"
    }
}

getHaterStatus(weather: WeatherType.cloud)


//Classes are used extensively in Cocoa touch

//Structs only use values (pass by value)
//Classes use references
