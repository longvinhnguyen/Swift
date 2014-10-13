//
//  ReversiBoard.swift
//  SwiftReversi
//
//  Created by Long Vinh Nguyen on 10/12/14.
//  Copyright (c) 2014 razeware. All rights reserved.
//

import Foundation

class ReversiBoard: Board {
    private (set) var blackScore = 0, whiteScore = 0
    
    func setInitialState() {
        clearBoard()
        super[3,3] = .White
        super[4,4] = .White
        super[3,4] = .Black
        super[4,3] = .Black
        
        blackScore = 2
        whiteScore = 2
    }
    
    func cellVisitor(fn: (BoardLocation)->()) {
        for column in 0..<self.boardSize {
            for row in 0..<self.boardSize {
            let location = BoardLocation(row: row, column: column)
                fn(location)
            }
        }
    }
    
    func clearBoard() {
        cellVisitor{self[$0] = .Empty}
    }
}