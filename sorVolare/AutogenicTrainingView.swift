import SwiftUI

struct AutogenicTrainingView: View {
    @State private var progress: CGFloat = 0.0
    @State private var phase: BreathingPhase = .inhale
    @State private var timer: Timer?
    @State private var isBreathingActive: Bool = false  // Stato per gestire l'attivazione della respirazione
    
    private enum BreathingPhase {
        case inhale, hold, exhale, holdAfterExhale
    }
    
    var body: some View {
        ZStack {
            
            Image("sfondo")
                .resizable()
                .frame(width: 1*UIScreen.main.bounds.width, height: 1*UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
        VStack {
            Spacer()
            Text("Square Breathing")
                .font(.largeTitle)
                .fontWeight(.medium)
                .padding()
           
            Text("Imagine one side of the square for every step, and at each one, complete one side until the square is finished!")
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .padding()
                .padding(.top, 25)
            
            Spacer()
            
            // Quadrato al posto dell'immagine
            Rectangle()
                .frame(width: 150, height: 150)
                .foregroundColor(.cyan)  // Puoi cambiare il colore a tuo piacimento
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
            
            // Bottone Start/Stop
            Button(action: {
                if isBreathingActive {
                    stopBreathingCycle()
                } else {
                    startBreathingCycle()
                }
                isBreathingActive.toggle()  // Cambia lo stato di attivazione
            }) {
                Text(isBreathingActive ? "Stop" : "Start")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.white)
                    .background(isBreathingActive ? Color.red : Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            Spacer()
        }
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
    
    private func stopBreathingCycle() {
        timer?.invalidate()  // Invalida il timer e ferma il ciclo
        progress = 0.0
        phase = .inhale
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
            if isBreathingActive {
                phase = nextPhase()
                advancePhase()
            }
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
    AutogenicTrainingView()
}
