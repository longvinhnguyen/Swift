//
//  BoardSquare.swift
//  SwiftReversi
//
//  Created by Long Vinh Nguyen on 10/12/14.
//  Copyright (c) 2014 razeware. All rights reserved.
//

import Foundation
import UIKit

class BoardSquare: UIView, BoardDelegate {
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
        
        board.addDelegate(self)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "cellTapped")
        self .addGestureRecognizer(tapRecognizer)
    }
    
    private func update() {
        let state = board[location]
        
        UIView.animateWithDuration(0.5) {
            switch (state) {
            case .White:
                self.whiteView.alpha = 1.0
                self.blackView.alpha = 0.0
                self.whiteView.transform = CGAffineTransformIdentity
                self.blackView.transform = CGAffineTransformMakeTranslation(0, 20)
            case .Black:
                self.whiteView.alpha = 0.0
                self.blackView.alpha = 1.0
                self.blackView.transform = CGAffineTransformIdentity
                self.whiteView.transform = CGAffineTransformMakeTranslation(0, -20)
            case .Empty:
                self.whiteView.alpha = 0.0
                self.blackView.alpha = 0.0
                
            }
        }
    }
    
    func cellStateChanged(location: BoardLocation) {
        if self.location == location {
            update()
        }
    }
    
    func cellTapped() {
        if board.isValidMove(location) {
            board.makeMove(location)
        }
    }
}


