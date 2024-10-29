//
//  PuzzlePieceView.swift
//  sorVolare
//
//  Created by Tulli-OS on 29/10/24.
//

import SwiftUI

struct PuzzlePieceView: View {
    @State var piece: PuzzlePiece
    let pieceSize: CGFloat
    @GestureState private var dragOffset = CGSize.zero
    
    var body: some View {
        piece.image
            .resizable()
            .frame(width: pieceSize, height: pieceSize)
            .position(x: piece.currentPosition.x + dragOffset.width, y: piece.currentPosition.y + dragOffset.height)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation
                    }
                    .onEnded { value in
                        piece.currentPosition.x += value.translation.width
                        piece.currentPosition.y += value.translation.height
                        checkIfInCorrectPosition()
                    }
            )
    }
    
    func checkIfInCorrectPosition() {
        if abs(piece.currentPosition.x - piece.correctPosition.x) < pieceSize / 2 && abs(piece.currentPosition.y - piece.correctPosition.y) < pieceSize / 2 {
            piece.currentPosition = piece.correctPosition
        }
    }
}
