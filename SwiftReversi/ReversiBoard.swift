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
    private (set) var gameFinished = false
    
    private let reversiBoardDelegates = DelegateMulticast<ReversiBoardDelegate>()
    
    override init() {
        super.init()
    }
    
    init(board:ReversiBoard) {
        super.init(board: board)
        nextMove = board.nextMove
        blackScore = board.blackScore
        whiteScore = board.whiteScore
    }
    
    func setInitialState() {
        clearBoard()
        super[3,3] = .White
        super[4,4] = .White
        super[3,4] = .Black
        super[4,3] = .Black
        
        blackScore = 2
        whiteScore = 2
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
        
        for direction in MoveDirection.directions {
            flipOpponentsCounters(location, direction: direction, toState: nextMove)
        }
        
        switchTurns()
        
        gameFinished = checkIfGameHasFinished()
        
        whiteScore = countMatches{self[$0] == BoardCellState.White}
        blackScore = countMatches{self[$0] == BoardCellState.Black}
        reversiBoardDelegates.invokeDelegates{$0.boardStateChanged()}
    }
    
    func moveSurroundsCounters(location:BoardLocation, direction: MoveDirection, toState:BoardCellState) -> Bool {
        var index = 1
        var currentLocation = direction.move(location)
     
        while isWithinBounds(currentLocation) {
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

    func addDelegate(delegate: ReversiBoardDelegate) {
        reversiBoardDelegates.addDelegate(delegate)
    }
    
    private func flipOpponentsCounters(location:BoardLocation, direction:MoveDirection, toState:BoardCellState) {
        if !moveSurroundsCounters(location, direction: direction, toState: toState) {
            return
        }
        
        let opponentState = toState.invert()
        var currentState = BoardCellState.Empty
        var currentLocation = location
        
        do {
            currentLocation = direction.move(currentLocation)
            currentState = self[currentLocation]
            self[currentLocation] = toState
        } while (isWithinBounds(currentLocation) && currentState == toState)
        
    }
    
    private func checkIfGameHasFinished() -> Bool {
        return !canPlayerMakeMove(BoardCellState.Black) && !canPlayerMakeMove(BoardCellState.White)
    }
    
    private func canPlayerMakeMove(toState:BoardCellState) -> Bool {
        return anyCellsMatchCondition{self.isValidMove($0, toState: toState)}
    }
    
    func switchTurns() {
        var intendedNextMove = nextMove.invert()
        if canPlayerMakeMove(intendedNextMove) {
            nextMove = intendedNextMove
        }
    }
    
    
    
}