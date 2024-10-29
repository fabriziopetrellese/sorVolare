//
//  BabyToyView.swift
//  sorVolare
//
//  Created by Tulli-OS on 28/10/24.
//

import SwiftUI

struct BabyToyView: View {
    @StateObject private var viewModel = Game1Model()
        let gridItems = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
        
        var drag: some Gesture {
            DragGesture()
                .onChanged { state in
                    viewModel.update(dragPosition: state.location)
                }
                .onEnded { state in
                    viewModel.update(dragPosition: state.location)
                    withAnimation {
                        viewModel.confirmWhereToyWasDropped()
                    }
                }
        }
        
        var body: some View {
            ZStack {
                VStack {
                    LazyVGrid(columns: gridItems, spacing: 35) {
                        ForEach(viewModel.toyContainers, id: \.id) { toy in
                            ToyContainer(
                                toy: toy,
                                viewModel: viewModel
                            )
                        }
                    }
                    Spacer()
                }
                if let currentToy = viewModel.currentToy {
                    DraggableToy(
                        toy: currentToy,
                        position: viewModel.currentPosition,
                        gesture: drag
                    )
                        .opacity(viewModel.draggableToyOpacity)
                }
            }
            .onAppear {
                viewModel.setNextToy()
            }
            .alert(
                Text("Congratulations, you won! 🎉"),
                isPresented: $viewModel.isGameOver,
                actions: {
                    Button("OK") {
                        withAnimation {
                            viewModel.generateNewGame()
                        }
                    }
                },
                message: {
                    Text("Number of attemps: \(viewModel.attempts)")
                }
            )
        }
    }

    struct BabyToyView_Previews: PreviewProvider {
        static var previews: some View {
            BabyToyView()
        }
    }
