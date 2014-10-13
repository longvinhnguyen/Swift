//
//  BoardLocation.swift
//  SwiftReversi
//
//  Created by Long Vinh Nguyen on 10/12/14.
//  Copyright (c) 2014 razeware. All rights reserved.
//

import Foundation

struct BoardLocation: Equatable {
    let row:Int;  let column:Int
    init(row:Int, column:Int) {
        self.row = row
        self.column = column
    }
}

func == (lhs: BoardLocation, rhs: BoardLocation) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}
