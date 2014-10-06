//
//  OrderedDictionary.swift
//  FlickrSearch
//
//  Created by LongNV on 10/6/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import Foundation

struct OrderedDictionary<KeyType: Hashable, ValueType> {
    typealias ArrayType = [KeyType]
    typealias DictionaryType = [KeyType: ValueType]
    
    var array = ArrayType()
    var dictionary = DictionaryType()
    
    mutating func insert(value: ValueType, forKey key: KeyType, atIndex index: Int) -> ValueType? {
        var adjustedIndex = index
        
        var existingValue = dictionary[key]
        
        if existingValue != nil {
            var existingIndex = find(self.array, key)!
            
            if existingIndex < index {
                adjustedIndex--
            }
            
            self.array.removeAtIndex(existingIndex)
        }
        
        self.array.insert(key, atIndex: adjustedIndex)
        self.dictionary[key] = value
        
        return existingValue;
    }
    
    mutating func removeAtIndex(index: Int) -> (KeyType, ValueType) {
        precondition(index < self.array.count, "Index out-of-bounds")
        
        let key = self.array.removeAtIndex(index)
        
        let value = self.dictionary.removeValueForKey(key)!
        
        return (key, value)
    }
    
    
    var count: Int {
        return self.array.count
    }
    
    subscript(key: KeyType) -> ValueType? {
        get {
            return self.dictionary[key]
        }
        
        set {
            if let index = find(self.array, key) {
                
            } else {
                self.array.append(key)
            }
            
            self.dictionary[key] = newValue
        }
    }
    
    subscript(index: Int) -> (KeyType, ValueType) {
        get {
            precondition(index < self.array.count, "Index out-of-bounds")
            
            let key = self.array[index]
            let value = self.dictionary[key]!
            
            return (key, value)
        }
        
        set {
            let (key, value) = newValue
            if let index = find(self.array, key) {
                
            } else {
                self.array.append(key)
            }
            self.dictionary[key] = value
        }
    }
 
}


extension OrderedDictionary: SequenceType {
    typealias GeneratorType = GeneratorOf<(KeyType, ValueType)>
    
    func generate() -> GeneratorOf<(KeyType, ValueType)> {
        var index = 0
        return GeneratorOf {
            if index < self.array.count {
                let key =  self.array[index++]
                return (key, self.dictionary[key]!)
            } else {
                return nil
            }
        }
    }
}




