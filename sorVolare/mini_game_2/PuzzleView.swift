//
//  PuzzleView.swift
//  sorVolare
//
//  Created by Tulli-OS on 29/10/24.
//

import SwiftUI

struct PuzzleView: View {
    @State private var pieces: [PuzzlePiece] = []
    @State private var isCompleted: Bool = false
    var gridSize = 3
    var pieceSize: CGFloat = 100
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                //background image with low opacity
                if let referenceImage = UIImage(named: "image_puzzle_2") {
                    Image(uiImage: referenceImage)
                        .resizable()
                        //.aspectRatio(contentMode: .fit)
                        //.frame(width: pieceSize * CGFloat(gridSize), height: pieceSize * CGFloat(gridSize))
                        .frame(width: 300, height: 300)
                        .opacity(0.2)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
                
                ForEach(pieces) { piece in
                    PuzzlePieceView(piece: piece, pieceSize: pieceSize)
                        .offset(x: geometry.size.width / 2 - pieceSize * CGFloat(gridSize / 2), y: geometry.size.height / 2 - pieceSize * CGFloat(gridSize) / 2)
                }
            }
            .onAppear {
                setUpPuzzle(screenSize: geometry.size)
            }
            .alert(isPresented: $isCompleted) {
                Alert(title: Text("Congratulations"), message: Text("Puzzle completed"), dismissButton: .default(Text("Ok")))
            }
        }
    }
    
    func setUpPuzzle(screenSize: CGSize) {
        guard let uiImage = UIImage(named: "image_puzzle_2") else { return }
        let images = splitImageIntoPieces(image: uiImage, gridSize: gridSize)
        pieces = []
        let puzzleAreaWidth = pieceSize * CGFloat(gridSize)
        let puzzleAreaHeight = pieceSize * CGFloat(gridSize)
        let minX = (screenSize.width - puzzleAreaWidth) / 2
        let minY = (screenSize.height - puzzleAreaHeight) / 2
        for row in 0..<gridSize {
            for col in 0..<gridSize {
                //let correctPosition = CGPoint(x: CGFloat(col) * pieceSize + pieceSize / 2, y: CGFloat(row) * pieceSize + pieceSize / 2)
                
                let correctPosition = CGPoint(x: CGFloat(col) * pieceSize, y: CGFloat(row) * pieceSize + pieceSize / 2)
                
                //Constrain the random position within the puzzle area
                let currentPosition = CGPoint(x: CGFloat.random(in: minX...(minX + puzzleAreaWidth - pieceSize)), y: CGFloat.random(in: minY...(minY + puzzleAreaHeight - pieceSize)))
                let piece = PuzzlePiece(image: Image(uiImage: images[row * gridSize + col]), correctPosition: correctPosition, currentPosition: currentPosition)
                pieces.append(piece)
            }
        }
    }
}




func splitImageIntoPieces(image: UIImage, gridSize: Int) -> [UIImage] {
    guard let cgImage = image.cgImage else { return [] }
    
    //let pieceWidth = CGFloat(cgImage.width) / CGFloat(gridSize)
    //let pieceHeight = CGFloat(cgImage.height) / CGFloat(gridSize)
    let pieceWidth = CGFloat(cgImage.width) / CGFloat(gridSize)
    let pieceHeight = CGFloat(cgImage.height) / CGFloat(gridSize)
    
    var pieces: [UIImage] = []
    
    for row in 0..<gridSize {
        for col in 0..<gridSize {
            let rect = CGRect(
                x: CGFloat(col) * pieceWidth,
                y: CGFloat(row) * pieceHeight,
                width: pieceWidth,
                height: pieceHeight
            )
            
            if let croppedCGImage = cgImage.cropping(to: rect) {
                let pieceImage = UIImage(cgImage: croppedCGImage)
                pieces.append(pieceImage)
            }
        }
    }
    
    return pieces
}
