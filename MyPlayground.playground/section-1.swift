// Playground - noun: a place where people can play

import UIKit
import Foundation

var greeting = "hello".stringByAppendingString(" world").capitalizedString
var alternateGreeting = greeting
alternateGreeting += " and beyond!"
println(alternateGreeting)
println(greeting)

var radius = 4
let pi = 3.14159
let milion = 1_000_000

var area = Double(radius) * Double(radius) * pi

let alwaysTrue = true
var address = (742, "Evergreen Terrace")
address.0 = 744
println(address.0)
println(address.1)

var address1:(Double, String) = (742, "Evergreen Terrace")
var address2 = (Double(742), "Evergreen Terrace")
var address3 = (742.0, "Evergreen Terrace")

let (house, street) = address
let str = "I live at \(house + 10), \(street.uppercaseString)"
println(str)

let greeting2 = "Swift by Tutorials Rocks"

var range = Range(start:1, end:5)
for i in range {
    println("\(i) - \(greeting2)")
}

for i in "Swift" {
    println(i)
}

var direction = "up"
switch direction {
case "down", "up":
    println("Going Somewhere")
default:
    println("Going Nowhere")
}

var score = 570
switch score {
case 1...100:
    println("novice")
case 10..<100:
    println("proficient")
case 100..<1000:
    println("rock-star")
default:
    println("awesome")
}




