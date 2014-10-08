// Playground - noun: a place where people can play

import UIKit

var events = [Int]()
for i in 1...10 {
    if i % 2 == 0 {
        events.append(i)
    }
}

println(events)

func isEven(number: Int) -> Bool {
    return number % 2 == 0
}

events = Array(1...10).filter {$0 % 2 == 0}

func myFilter<T>(source: [T], predicate: (T)->Bool) -> [T] {
    var result = [T]()
    for i in source {
        if predicate(i) {
            result.append(i)
        }
    }
    
    return result
}

var evens = myFilter(Array(1...10)) { $0 % 2 == 0 }
println(evens)



// Challenge
extension Array {
    func myFilter<T>(predicate: (T) -> Bool) -> [T]{
        var result = [T]()
        for i in self {
            if let number = i as? T {
                if predicate(number) {
                    result.append(number)
                }
            }

        }
        return result
    }
    
    func myReduce<T, U>(seed: U, combiner:(U, T) -> U) -> U {
        var current = seed
        for item in self {
            current = combiner(current, item as T)
        }
        
        return current
    }
}

var newArray = Array(10..<100).myFilter(isEven)
println(newArray)

var evenSum = Array(1...10).myFilter(isEven).reduce(0) {(total, number) in total + number}
println(evenSum)

let maxNumber = Array(1...10).myFilter(isEven).reduce(0) {(total, number) in max(total, number)}
println(maxNumber)


let stringConvertedNumber = ["3", "1", "4", "1"].myReduce(0) {
    (total, number) in
    (String(total) + number).toInt()!
}

println(stringConvertedNumber)


























