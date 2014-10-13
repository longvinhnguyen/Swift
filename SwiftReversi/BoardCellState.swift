//
//  BoardCellState.swift
//  SwiftReversi
//
//  Created by Long Vinh Nguyen on 10/12/14.
//  Copyright (c) 2014 razeware. All rights reserved.
//

import Foundation

enum BoardCellState {
    case Black, White, Empty
    
    func invert() -> BoardCellState {
        if self == Black {
            return White
        } else if self == White {
            return Black
        }
        
        assert(self != Empty , "cannot invert the empty state")
        return Empty
    }
}