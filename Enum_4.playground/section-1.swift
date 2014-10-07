// Playground - noun: a place where people can play

import UIKit

enum Shape {
    case Rectangle(width: Float, height: Float)
    case Square(Float)
    case Triangle(base: Float, height: Float)
    case Circle(Float)
    
    
    init(_ rect:CGRect) {
        let width = Float(CGRectGetWidth(rect))
        let height = Float(CGRectGetHeight(rect))
        if width == height {
            self = Square(width)
        } else {
            self = Rectangle(width: width, height: height)
        }
    }
    
    static func fromString(string: String) -> Shape? {
        switch(string) {
            case "rectangle":
                return Rectangle(width: 5, height: 10)
            case "square":
                return Square(5)
            case "triangle":
                return Triangle(base: 5, height: 10)
            case "circle":
                return Circle(5)
            default:
                return nil
        }
    }
    
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
    
    func perimeter() -> Float {
        switch(self) {
        case .Rectangle(let width, let height):
            return (width + height) * 2
        case .Square(let side):
            return 4 * side
        case .Triangle(let base, let height):
            return 0
        case .Circle(let radius):
            return 2 * Float(M_PI) * radius
        }
    }

}

var circle = Shape.Circle(5)
switch circle {
case .Circle(let radius):
    println(radius)
default:
    break
}
println(String(format: "%.2f", circle.area()))
println(String(format: "%.2f", circle.perimeter()))

var shape = Shape(CGRect(x: 0, y: 0, width: 5, height: 10))
println(shape.area())

if let anotherShape = Shape.fromString("square") {
    println(anotherShape.area())
}

let json = "{\"success\":true,\"data\":{\"numbers\":[1,2,3,4,5],\"animal\":\" dog\"}}"


enum JSONValue {
    case JSONObject([String: JSONValue])
    case JSONArray([JSONValue])
    case JSONString(String)
    case JSONNumber(NSNumber)
    case JSONBool(Bool)
    case JSONNull
    
    subscript(key: String) -> JSONValue? {
        get {
            switch(self) {
            case .JSONObject(let value):
                return value[key]
            default:
                return nil
            }
        }
    }
    
    var object: [String:JSONValue]? {
        switch self {
        case .JSONObject(let value):
            return value
        default:
            return nil
            }
    }
    
    var array: [JSONValue]? {
        switch self {
        case .JSONArray(let value):
            return value
        default:
            return nil
            }
    }
    
    var string: String? {
        switch self {
        case .JSONString(let value):
            return value
        default:
            return nil
            }
    }
    
    var integer: Int? {
        switch self {
        case .JSONNumber(let value):
            return value.integerValue
        default:
            return nil
            }
    }
    
    var double: Double? {
        switch self {
        case .JSONNumber(let value):
            return value.doubleValue
        default:
            return nil
            }
    }
    
    var bool: Bool? {
        switch self {
        case .JSONBool(let value):
            return value
        case .JSONNumber(let value):
            return value.boolValue
        default:
            return nil
            }
    }
    
    static func fromObject(object: AnyObject) -> JSONValue? {
        switch object {
        case let value as NSString:
            return JSONValue.JSONString(value)
        case let value as NSNumber:
            return JSONValue.JSONNumber(value)
        case let value as NSNull:
            return JSONValue.JSONNull
        case let value as NSDictionary:
            var jsonObject: [String:JSONValue] = [:]
            for (k:AnyObject, v:AnyObject) in value {
                if let k = k as? NSString {
                    if let v = JSONValue.fromObject(v) {
                        jsonObject[k] = v
                    } else {
                        return nil
                    }
                }
            }
            return JSONValue.JSONObject(jsonObject)
            
        case let value as NSArray:
            var jsonArray:[JSONValue] = []
            for v in value {
                if let v = JSONValue.fromObject(v) {
                    jsonArray.append(v)
                } else {
                    return nil
                }
            }
            return JSONValue.JSONArray(jsonArray)
            
            
        default:
            return nil
        }

    }
}


if let jsonData = json.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true) {
    println("ok")
    if let parsed:AnyObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.fromRaw(0)!, error: nil) {
        if let jsonParsed = JSONValue.fromObject(parsed) {
            if jsonParsed["success"]?.bool == true {
                if let numbers = jsonParsed["data"]?["numbers"]?.array {
                    for number in numbers {
                        println(number.integer!)
                    }
                }
                if let animal = jsonParsed["data"]?["animal"]?.string {
                    println(animal)
                }
            }
        }
    }
}



















