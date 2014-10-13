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
    private (set) var nextMove = BoardCellState.White
    
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
    
    func isValidMove(location:BoardLocation) -> Bool {
        return isValidMove(location, toState: nextMove)
    }
    
    func isValidMove(location:BoardLocation, toState:BoardCellState) -> Bool {
        if self[location] != BoardCellState.Empty {
            return false
        }
        
        // test whether the move surrounds any of the opponent pieces
        for direction in MoveDirection.directions {
            if moveSurroundsCounters(location, direction: direction, toState: toState) {
                return true
            }
        }
            
        return false
    }
    
    func makeMove(location:BoardLocation) {
        self[location] = nextMove
        nextMove = nextMove.invert()
    }
    
    func moveSurroundsCounters(location:BoardLocation, direction: MoveDirection, toState:BoardCellState) -> Bool {
        var index = 1
        var currentLocation = direction.move(location)
     
        while isWithinBounds(location) {
            let currentState = self[currentLocation]
            if index == 1 {
                if currentState != toState.invert() {
                    return false
                }
             } else {
                if currentState == toState {
                    return true
                }
                
                if currentState == BoardCellState.Empty {
                    return false
                }
            }

            index++
            
            // move to the next cell
            currentLocation = direction.move(currentLocation)
        }

        return false
    }

    
    
    
    
    
    
    
    
    
    
    
}