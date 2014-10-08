// Playground - noun: a place where people can play

import UIKit

enum Shape {
    case Rectangle(width: Float, height: Float)
    case Square(Float)
    case Triangle(base: Float, height: Float)
    case Circle(Float)
    
    func area() -> Float {
        switch(self) {
        case .Rectangle(let width, let height):
            return width * height
        case .Square(let side):
            return side * side
        case .Triangle(let base, let height):
            return 0.5 * base * height
        case .Circle(let radius):
            return Float(M_PI) * powf(radius, 2)
        }
    }
}

var rectangle = Shape.Rectangle(width: 5, height: 10)
var triangle = Shape.Triangle(base: 12, height: 24)
var circle = Shape.Circle(3)

switch(circle) {
case .Rectangle(let width, let height) where width == height:
    println("Square: \(width) x \(height)")
case .Rectangle(let width, let height):
    println("Wide rectangle: \(width) x \(height)")
case .Square(let side):
    println("Square: \(side) x \(side)")
case .Rectangle(let width, let height) where width < 10:
    println("Narrow rectangle: \(width) x \(height)")
case .Triangle(let base, let height) where height > 10:
    println("Triangles that are taller than 10")
case .Triangle(let base, let height) where height == 2 * base:
    println("Triangles whose height is twice their base")
case .Circle(let radius) where radius < 5:
    println("Circles that have a radius smaller than 5")
default:
    println("Other shape")
}

println(rectangle.area())
println(triangle.area())
println(circle.area())