//
//  BoardSquare.swift
//  SwiftReversi
//
//  Created by Long Vinh Nguyen on 10/12/14.
//  Copyright (c) 2014 razeware. All rights reserved.
//

import Foundation
import UIKit

class BoardSquare: UIView {
    private let board: ReversiBoard
    private let location: BoardLocation
    private let blackView: UIImageView
    private let whiteView: UIImageView
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, board:ReversiBoard, location:BoardLocation) {
        self.board = board
        self.location = location
        
        let whiteImage = UIImage(named: "ReversiWhitePiece.png")
        whiteView = UIImageView(image: whiteImage)
        whiteView.alpha = 0
        
        let blackImage = UIImage(named: "ReversiBlackPiece.png")
        blackView = UIImageView(image: blackImage)
        blackView.alpha = 0
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        
        self.addSubview(blackView)
        self.addSubview(whiteView)
        
        update()
    }
    
    private func update() {
        let state = board[location]
        whiteView.alpha = state == BoardCellState.White ?1.0 : 0.0
        blackView.alpha = state == BoardCellState.Black ?1.0 : 0.0
    }
}


