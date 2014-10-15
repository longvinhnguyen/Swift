//
//  Board.swift
//  SwiftReversi
//
//  Created by Long Vinh Nguyen on 10/12/14.
//  Copyright (c) 2014 razeware. All rights reserved.
//

import Foundation

class Board {
    private var cells:[BoardCellState]
    private let boardDelegates = DelegateMulticast<BoardDelegate>()
    let boardSize = 8
    
    init() {
        cells = Array(count:boardSize * boardSize, repeatedValue:BoardCellState.Empty)
    }
    
    init(board:Board) {
        cells = board.cells
    }
    
    subscript(location:BoardLocation) -> BoardCellState {
        get {
            assert(isWithinBounds(location), "row or column index out of bounds")
            return cells[location.row * boardSize + location.column]
        }
        set {
            assert(isWithinBounds(location), "row or column index out of bounds")
            cells[location.row * boardSize + location.column] = newValue
            boardDelegates.invokeDelegates {$0.cellStateChanged(location)}
        }
    }
    
    subscript(row:Int, column:Int) -> BoardCellState {
        get {
            return self[BoardLocation(row: row, column: column)]
        }
        set {
            self[BoardLocation(row: row, column: column)] = newValue
        }
    }
    
    func cellVisitor(fn: (BoardLocation)->()) {
        for column in 0..<self.boardSize {
            for row in 0..<self.boardSize {
                let location = BoardLocation(row: row, column: column)
                fn(location)
            }
        }
    }
    
    func isWithinBounds(location: BoardLocation) -> Bool {
        return location.row >= 0 && location.column >= 0 && location.row < boardSize && location.column < boardSize
    }
    
    func addDelegate(delegate:BoardDelegate) {
        boardDelegates.addDelegate(delegate)
    }
    
    func countMatches(fn:(BoardLocation) -> Bool) -> Int {
        var count = 0
        cellVisitor{if fn($0) {count++}}
        
        return count
    }
    
    func anyCellsMatchCondition(fn:(BoardLocation)->Bool) -> Bool {
        for column in 0..<boardSize {
            for row in 0..<boardSize {
                if fn(BoardLocation(row: row, column: column)) {
                    return true
                }
            }
        }
        return false
    }
    
    
}