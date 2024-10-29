//
//  pazzlepiece.swift
//  sorVolare
//
//  Created by Tulli-OS on 29/10/24.
//

import SwiftUI

struct PuzzlePiece: Identifiable {
    var id = UUID()
    var image: Image
    var correctPosition: CGPoint
    var currentPosition: CGPoint
}
