// Playground - noun: a place where people can play

import UIKit

var str: String! = "Hello Swift by tutorials"
if str != nil {
    str = str.lowercaseString
    println(str)
}

var array: [AnyObject] = [1, 2, 3, 4, 5]
println(array[2])
array.append(6)
array.append("11")
array.append("This is")
println(array)

var dictionary: [Int:String] = [1: "Dog", 2: "Cat"]
if let value = dictionary[1]
{
    println("Value is \(value)")}
dictionary[3] = "Mouse"
dictionary[2] = "Elephant"
println(dictionary)
dictionary[3] = nil
println(dictionary)

var arrayA = [1, 2, 3, 4, 5]
var arrayB = arrayA
println(arrayA)
println(arrayB)arrayB[0] = 2
println(arrayA)
println(arrayB)



