import SwiftUI

struct AutogenicTrainingView: View {
    @State private var progress: CGFloat = 0.0
    @State private var phase: BreathingPhase = .inhale
    @State private var timer: Timer?
    @State private var isBreathingActive: Bool = false
    
    private enum BreathingPhase {
        case inhale, hold, exhale, holdAfterExhale
    }
    
    var body: some View {
        ZStack {
            
            Image("sfondo")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
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
                
                ZStack {
                    Color.clear.frame(width: 150, height: 150)
                    
                    Rectangle()
                        .frame(width: 155, height: 7) // Top side
                        .foregroundColor(phase == .inhale ? .red : .cyan)
                        .offset(y: -75)
                    
                    Rectangle()
                        .frame(width: 155, height: 7) // Bottom side
                        .foregroundColor(phase == .hold ? .red : .cyan)
                        .offset(y: 75)
                    
                    Rectangle()
                        .frame(width: 7, height: 156) // Left side
                        .foregroundColor(phase == .exhale ? .red : .cyan)
                        .offset(x: -75)
                    
                    Rectangle()
                        .frame(width: 7, height: 156) // Right side
                        .foregroundColor(phase == .holdAfterExhale ? .red : .cyan)
                        .offset(x: 75)
                }
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
                
                Button(action: {
                    if isBreathingActive {
                        stopBreathingCycle()
                    } else {
                        startBreathingCycle()
                    }
                    isBreathingActive.toggle()
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
        timer?.invalidate()
        phase = .inhale
        progress = 0.0
        advancePhase()
    }
    
    private func stopBreathingCycle() {
        timer?.invalidate()
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
            progress = 0.0
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
            return .holdAfterExhale
        case .holdAfterExhale:
            return .inhale
        }
    }
}



#Preview {
    AutogenicTrainingView()
}
