// Playground - noun: a place where people can play

import UIKit

func distinct<T: Equatable>(source: [T]) -> [T] {
    var unique = [T]()
    for item in source {
        if !contains(unique, item) {
            unique.append(item)
        }
    }
    
    return unique
}

let words = ["Cat", "Chicken", "fish", "Dog", "Mouse", "Guinea Pig", "monkey"]

typealias Entry = (Character, [String])

func buildIndex(words: [String]) -> [Entry] {
    func firstLetter(str: String) -> Character {
        return Character(str.substringToIndex(advance(str.startIndex, 1)).uppercaseString)
    }
    
    return distinct(sorted(words.map(firstLetter))).map {
        (letter) -> Entry in
        return Entry(letter, words.filter {
                (word) -> Bool in
                firstLetter(word) == letter
            })
    }
}

println(buildIndex(words))

let data = "5,7;3,4;55,6"
print(data.componentsSeparatedByString(";"))

func createSplitter(separator:String)(source:String) -> [String] {
    return source.componentsSeparatedByString(separator)
}

let commaSplitter = createSplitter(",")
println(commaSplitter(source:data))let semiColonSplitter = createSplitter(";")
println(semiColonSplitter(source:data))


func addNumbers(one:Int, two:Int, three:Int) -> Int {
    return one + two + three
}

let sum = addNumbers(2, 5, 4)
println(sum)

func curryAddNumbers(one:Int)(two:Int)(three:Int) -> Int {
    return one + two + three
}

let stepOne = curryAddNumbers(2)
let stepTwo = stepOne(two:5)
let stepThree = stepTwo(three:5)
println(stepThree)

let result2 = curryAddNumbers(2)(two:5)(three:5)
println(result2)

let text = "Swift"

func curriedPadding(startingAtIndex: Int, withString: String)(source:String, length:Int) -> String {
    return source.stringByPaddingToLength(length, withString:withString, startingAtIndex:startingAtIndex)
}

let dotPadding = curriedPadding(0, ".")
let dotPadded = dotPadding(source: "Curry", length: 10)
println(dotPadded)







