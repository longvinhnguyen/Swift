//
//  DelegateMulticast.swift
//  SwiftReversi
//
//  Created by Long Vinh Nguyen on 10/13/14.
//  Copyright (c) 2014 razeware. All rights reserved.
//

import Foundation

class DelegateMulticast<T> {
    private var delegates = [T]()
    func addDelegate(delegate: T) {
        delegates.append(delegate)
    }
    
    func invokeDelegates(invocation: (T) -> ()) {
        for delegate in delegates {
            invocation(delegate)
        }
    }
}