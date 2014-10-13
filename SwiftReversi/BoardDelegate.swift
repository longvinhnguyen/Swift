//
//  BoardDelegate.swift
//  SwiftReversi
//
//  Created by Long Vinh Nguyen on 10/13/14.
//  Copyright (c) 2014 razeware. All rights reserved.
//

import Foundation

protocol BoardDelegate {
    func cellStateChanged(location:BoardLocation)
}
