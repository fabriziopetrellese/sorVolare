//
//  AutogenicTrainingView.swift
//  sorVolare
//
//  Created by Tulli-OS on 28/10/24.
//

import SwiftUI

struct AutogenicTrainingView: View {
    
    
    @State private var isBreathingIn = true
        @State private var progress: Double = 0.0
        @State private var timer: Timer? = nil

        var body: some View {
            VStack {
                Text(isBreathingIn ? "Inhale" : "Exhale")
                    .font(.largeTitle)
                    .padding()
                    .onAppear {
                        startBreathing()
                    }

                ProgressView(value: progress, total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle())
                    .frame(width: 300)
                    .padding()
            }
        }

        private func startBreathing() {
            progress = 0.0
            timer?.invalidate() // Cancella eventuali timer esistenti

            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                if isBreathingIn {
                    progress += 0.025 // Incrementa il progresso
                    if progress >= 1.0 {
                        isBreathingIn.toggle()
                        progress = 1.0
                    }
                } else {
                    progress -= 0.025 // Decrementa il progresso
                    if progress <= 0.0 {
                        isBreathingIn.toggle()
                        progress = 0.0
                    }
                }
            }
        }
    
}

#Preview {
    AutogenicTrainingView()
}
