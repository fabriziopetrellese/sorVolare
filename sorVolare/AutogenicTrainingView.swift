//
//  AutogenicTrainingSessionView.swift
//  SirVolare
//
//  Created by Tulli-OS on 31/10/24.
//

import AudioToolbox
import SwiftUI
import AVFAudio

struct AutogenicTrainingView: View {
    @State private var currentPhase: BreathingPhase = .exhaling
    @State private var animationScale: CGFloat = 0.5
    @State private var isBreathing: Bool = false
    private let breathingDuration: TimeInterval = 4.0 // Durata di ogni fase in secondi
    @State private var timer: Timer?
    
    enum BreathingPhase {
        case inhaling, holding, exhaling, holdingAfterExhale
    }
    
    var body: some View {
        VStack {
            Text("Respirazione Quadratica")
                .font(.largeTitle)
                .padding()
            
            Text(phaseText())
                .font(.system(size: 48))
                .fontWeight(.bold)
                .foregroundColor(phaseColor())
                .padding()
            
            Circle()
                .fill(phaseColor().opacity(0.3))
                .scaleEffect(animationScale)
                .frame(width: 200, height: 200) // Dimensioni del cerchio
                .animation(.easeInOut(duration: breathingDuration), value: animationScale)
            
            Spacer()
            
            Button(action: {
                isBreathing.toggle()
                if isBreathing {
                    startBreathing()
                } else {
                    stopBreathing()
                }
            }) {
                Text(isBreathing ? "Ferma" : "Inizia")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            // Descrizione
            Text("Esegui la respirazione quadratica: Inspira, trattieni, espira e ripeti.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
    
    private func startBreathing() {
        currentPhase = .inhaling
        animationScale = 0.5
        performBreathingCycle()
    }
    
    private func stopBreathing() {
        isBreathing = false
        currentPhase = .inhaling
        animationScale = 0.5 // Ripristina il cerchio
        timer?.invalidate()
    }
    
    private func performBreathingCycle() {
        guard isBreathing else { return }
        
        switch currentPhase {
            
            
        case .exhaling:
            animationScale = 1.0
            currentPhase = .holdingAfterExhale
        case .holdingAfterExhale:
            animationScale = 0.5
            currentPhase = .inhaling
        case .inhaling:
            animationScale = 1.0
            currentPhase = .holding
        case .holding:
            animationScale = 0.5
            currentPhase = .exhaling
            
            
            
        }
        
        // Pianifica il passaggio alla fase successiva
        DispatchQueue.main.asyncAfter(deadline: .now() + breathingDuration) {
            performBreathingCycle()
        }
    }
    
    private func phaseText() -> String {
        switch currentPhase {
        case .inhaling:
            return "Inspira"
        case .holding:
            return "Trattieni il respiro"
        case .exhaling:
            return "Espira"
        case .holdingAfterExhale:
            return "Aspetta ad inspirare"
        }
    }
    
    private func phaseColor() -> Color {
        switch currentPhase {
        case .inhaling:
            return .green
        case .holding:
            return .yellow
        case .exhaling:
            return .red
        case .holdingAfterExhale:
            return .orange
        }
    }
}


#Preview {
    //AutogenicTrainingView()
}
