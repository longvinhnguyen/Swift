// Playground - noun: a place where people can play

import UIKit

func square(number:Double) -> Double {
    return number * number
}

typealias OperationType = (Double) -> Double
let operation:OperationType = square

let a = 3.0; let b = 4.0
let c = sqrt(operation(a) + operation(b))
println(c)

func logDouble(number: Double) {
    println(String(format: "%.2f", number))
}

var logger:(Double) -> () = logDouble

func checkAreEqual<T: Equatable>(input: T, value: T, message: String) {
    if input != value {
        println(message)
    }
}

checkAreEqual(2, 59.13, "An input of '3' was expected.")
checkAreEqual("wolf", "wolf", "An input of 'wolf' was expected.")

struct Person {
    var age = 34, name = "Colin"
    
    mutating func growOlder() {
        self.age++
    }
}

func celebrateBirthday(inout cumpleañero: Person) {
    println("Happy Birthday \(cumpleañero.name)")
    cumpleañero.growOlder()
}


var person = Person()
celebrateBirthday(&person)
println(person.age)

func longestWord(words: String...) -> String? {
    return words.reduce(String?()) {
        (longest, word) in
        return longest == nil || countElements(longest!) < countElements(word) ? word: longest
    }
}

let long = longestWord("chick", "fish", "cat", "elephant")
println(long)


class Cell: Printable {
    
    private(set) var row = 0
    private(set) var column = 0
    
    func move(x: Int = 0, y: Int = 0) {
        row += y
        column += x
    }
    
    func moveByX(x: Int) {
        column += x
    }
    
    func moveByY(y: Int) {
        column += y
    }
    
    var description: String {
        get {
            return "Cell [row=\(row), col=\(column)]"
        }
    }
}

var cell = Cell()
var instanceFunc = Cell.moveByX
instanceFunc(cell)(34)
println(cell.description)

let animals = ["fish", "cat", "chicken", "dog"]

let sortedString = animals.sorted(>)
println(sortedString)

typealias StateMachineType = () -> Int

func makeStateMachine(maxState: Int) -> StateMachineType {
    var currentState: Int = 0
    return {
        currentState++
        if currentState > maxState {
            currentState = 0
        }
        
        return currentState
        
    }
}

let tristate = makeStateMachine(1)
println(tristate())
println(tristate())
println(tristate())
println(tristate())
println(tristate())
println(tristate())
println(tristate())
println(tristate())
println(tristate())







