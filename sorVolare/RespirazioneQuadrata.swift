//
//  RespirazioneQuadrata.swift
//  sorVolare
//
//  Created by Fabrizio Petrellese on 01/11/24.
//

import SwiftUI

struct RespirazioneQuadrata: View {
    @State private var progress: CGFloat = 0.0
    @State private var phase: BreathingPhase = .inhale
    @State private var timer: Timer?
    
    private enum BreathingPhase {
        case inhale, hold, exhale, holdAfterExhale
    }
    
    var body: some View {
        VStack {
            Text("Imagine one side of the box for every step, and at each one, complete one side until the square is finished!")
                .font(.title)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .padding()
                .padding(.top, 25)
            
            Spacer()
            
            Image("noBack")
                .resizable()
                .frame(width: 250, height: 250)
                .padding()
            
            Spacer()
            
            Text(phaseText())
                .font(.largeTitle)
                .fontWeight(.medium)
                .padding(.bottom, 20)
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(height: 20)
                    .foregroundColor(Color.gray.opacity(0.2))
                
                Rectangle()
                    .frame(width: progress * 300, height: 20)
                    .foregroundColor(.blue)
            }
            .cornerRadius(10)
            .frame(width: 300)
            
            Spacer()
        }
        .onAppear {
            startBreathingCycle()
        }
    }
    
    private func phaseText() -> String {
        switch phase {
        case .inhale:
            return "Inhale"
        case .hold:
            return "Hold"
        case .exhale:
            return "Exhale"
        case .holdAfterExhale:
            return "Hold"
        }
    }
    
    private func startBreathingCycle() {
        timer?.invalidate()  // Cancella eventuali timer precedenti
        phase = .inhale
        progress = 0.0
        advancePhase()
    }
    
    private func advancePhase() {
        let duration: TimeInterval = 4.0
        
        switch phase {
        case .inhale:
            progress = 0.0
            withAnimation(.linear(duration: duration)) {
                progress = 1.0
            }
        case .hold:
            progress = 1.0
        case .exhale:
            progress = 1.0
            withAnimation(.linear(duration: duration)) {
                progress = 0.0
            }
        case .holdAfterExhale:
            progress = 0.0 // La barra rimane fissa
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            phase = nextPhase()
            advancePhase()
        }
    }
    
    private func nextPhase() -> BreathingPhase {
        switch phase {
        case .inhale:
            return .hold
        case .hold:
            return .exhale
        case .exhale:
            return .holdAfterExhale // Passa alla fase hold dopo exhale
        case .holdAfterExhale:
            return .inhale // Torna a inhale
        }
    }
    
}

#Preview {
    RespirazioneQuadrata()
}
