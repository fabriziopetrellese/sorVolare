import SwiftUI

struct AutogenicTrainingView: View {
    
    @State private var progress: CGFloat = 0.0
    @State private var phase: BreathingPhase = .inhale
    @State private var isBreathingActive: Bool = false
    @State private var dotPosition: CGPoint = CGPoint(x: -95, y: -95)
    @State private var durataAnimazione = 0.0
    @State private var cerchioInternoSize: CGFloat = 1.1 // Scale of the inner circle
    
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
                    Rectangle()
                        .frame(width: 195, height: 5) // Lato alto
                        .foregroundColor(.cyan)
                        .offset(y: -95)
                    
                    Rectangle()
                        .frame(width: 5, height: 190) // Lato destro
                        .foregroundColor(.cyan)
                        .offset(x: 95)
                    
                    Rectangle()
                        .frame(width: 195, height: 5) // Lato basso
                        .foregroundColor(.cyan)
                        .offset(y: 95)
                    
                    Rectangle()
                        .frame(width: 5, height: 190) // Lato sinistro
                        .foregroundColor(.cyan)
                        .offset(x: -95)
                    
                    // Cerchio che si muove lungo il quadrato
                    Circle()
                        .frame(width: 15, height: 15)
                        .foregroundColor(.red)
                        .offset(x: dotPosition.x, y: dotPosition.y)
                        .animation(.linear(duration: durataAnimazione), value: dotPosition)
                    
                    // Secondo cerchio che si espande e contrae
                    Circle()
                        .frame(width: 47, height: 47)
                        .foregroundColor(.blue.opacity(0.15))
                        .scaleEffect(cerchioInternoSize) // Adjust scale based on breathing phase
                        .animation(.easeInOut(duration: durataAnimazione), value: cerchioInternoSize)
                    
                    // Terzo cerchio che si espande e contrae
                    Circle()
                        .frame(width: 51, height: 51)
                        .foregroundColor(.blue.opacity(0.10))
                        .scaleEffect(cerchioInternoSize) // Adjust scale based on breathing phase
                        .animation(.easeInOut(duration: durataAnimazione), value: cerchioInternoSize)
                    
                    // Quarto cerchio che si espande e contrae
                    Circle()
                        .frame(width: 55, height: 55)
                        .foregroundColor(.blue.opacity(0.05))
                        .scaleEffect(cerchioInternoSize) // Adjust scale based on breathing phase
                        .animation(.easeInOut(duration: durataAnimazione), value: cerchioInternoSize)
                    
                    Text(phaseText())
                        .font(.headline)
                        .fontWeight(.medium)
                        .padding(.bottom, 20)
                        .offset(y: 8)
                }
                
                Spacer()
                
                Spacer()
                
                Button(action: {
                    isBreathingActive.toggle()
                    if isBreathingActive {
                        durataAnimazione = 4.0
                        startBreathing()
                    } else {
                        stopBreathing()
                    }
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
    
    private func stopBreathing() {
        phase = .inhale
        durataAnimazione = 0.0
        dotPosition = CGPoint(x: -95, y: -95) // Reset dot position
        cerchioInternoSize = 1.1 // Reset inner circle scale
    }
    
    private func startBreathing() {
        
        switch phase {
        case .inhale:
            dotPosition = CGPoint(x: 95, y: -95) // Move to top side
            cerchioInternoSize = 3 // Expand the inner circle
        case .hold:
            dotPosition = CGPoint(x: 95, y: 95) // Move down to right side
            cerchioInternoSize = 3 // Hold the expanded size
        case .exhale:
            dotPosition = CGPoint(x: -95, y: 95) // Move to bottom side
            cerchioInternoSize = 1.1 // Contract the inner circle
        case .holdAfterExhale:
            dotPosition = CGPoint(x: -95, y: -95) // Move back to left side
            cerchioInternoSize = 1.1 // Hold the contracted size
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + durataAnimazione) {
            if isBreathingActive {
                phase = nextPhase()
                startBreathing()
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
