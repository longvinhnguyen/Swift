//
//  ReversiBoardView.swift
//  SwiftReversi
//
//  Created by Long Vinh Nguyen on 10/12/14.
//  Copyright (c) 2014 razeware. All rights reserved.
//

import Foundation
import UIKit

class ReversiBoardView: UIView {
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, board:ReversiBoard) {
        super.init(frame: frame)
        
        let rowHeight = frame.size.height / CGFloat(board.boardSize)
        let columnWidth = frame.size.width / CGFloat(board.boardSize)
        
        board.cellVisitor {
            (location:BoardLocation) in
            let left = (CGFloat)(location.column) * columnWidth
            let top = (CGFloat)(location.row) * rowHeight
            let squareFrame = CGRect(x: left, y: top, width:columnWidth, height:rowHeight)
            let square = BoardSquare(frame: squareFrame, board:board, location:location)
            self.addSubview(square)
        }
    }
}