import SwiftUI

struct AwarenessTrainingView: View {
    @State private var isMeditating: Bool = false
    @State private var currentPhase: Int = 0
    @State private var meditationTimer: Timer?
    @State private var thoughts: String = ""
    @State private var savedThoughts: [Thought] = []
    
    @FocusState private var isKeyboardVisible: Bool // FocusState per monitorare la tastiera

    private let phases = [
        "Write down what you feel... 📝"
    ]
    
    var body: some View {
        
        VStack {
            Text("Self-Awareness")
                .font(.largeTitle)
                .padding()
            
            Text(phases[currentPhase])
                .font(.title)
                .padding()
            
            TextField("Write down your thoughts...", text: $thoughts)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .frame(height: 100)
                .submitLabel(.done)
                .focused($isKeyboardVisible)  // Usa FocusState per monitorare la tastiera
                .onSubmit {
                    isKeyboardVisible = false // Chiude la tastiera quando si preme "Done"
                }
            
            Text("Associate an emotion with your thought")
            
            HStack {
                Button("Serenity") {
                    saveThought(thoughts, emotion: "Serenity")
                    thoughts = ""
                    isKeyboardVisible = false // Chiude la tastiera
                }
                .buttonStyle(EmotionButtonStyle())
                
                Button("Fear") {
                    saveThought(thoughts, emotion: "Fear")
                    thoughts = ""
                    isKeyboardVisible = false // Chiude la tastiera
                }
                .buttonStyle(EmotionButtonStyle())
                
                Button("Joy") {
                    saveThought(thoughts, emotion: "Joy")
                    thoughts = ""
                    isKeyboardVisible = false // Chiude la tastiera
                }
                .buttonStyle(EmotionButtonStyle())
                
                Button("Anger") {
                    saveThought(thoughts, emotion: "Anger")
                    thoughts = ""
                    isKeyboardVisible = false // Chiude la tastiera
                }
                .buttonStyle(EmotionButtonStyle())
            }
            
            List(savedThoughts.reversed(), id: \.id) { thought in  // Inversione dell'ordine della lista
                VStack(alignment: .leading) {
                    Text("Thought: \(thought.text)")
                    Text("Emotion: \(thought.emotion)")
                        .foregroundColor(.gray)
                }
            }
            
            // Pulsante per pulire la lista
            Button("Clear the list") {
                clearThoughts()
            }
            .padding()
            .buttonStyle(EmotionButtonStyle())
        }
        .toolbar {
            // Aggiungi il pulsante "Done" sopra la tastiera
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    isKeyboardVisible = false // Chiude la tastiera
                }
            }
        }
        .onAppear {
            loadSavedThoughts()
        }
        .onDisappear {
            stopMeditation()
        }
    }
    
    private func startMeditation() {
        isMeditating = true
        currentPhase = 0
        meditationTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { _ in
            updatePhase()
        }
    }
    
    private func stopMeditation() {
        isMeditating = false
        meditationTimer?.invalidate()
        meditationTimer = nil
        thoughts = ""
    }
    
    private func updatePhase() {
        currentPhase = (currentPhase + 1) % phases.count
    }
    
    private func saveThought(_ thoughtText: String, emotion: String) {
        let thought = Thought(text: thoughtText, emotion: emotion)
        savedThoughts.append(thought)
        saveThoughtsToFile()
    }
    
    private func saveThoughtsToFile() {
        do {
            let data = try JSONEncoder().encode(savedThoughts)
            let url = getDocumentsDirectory().appendingPathComponent("thoughts.json")
            try data.write(to: url)
        } catch {
            print("Error saving thoughts: \(error)")
        }
    }
    
    private func loadSavedThoughts() {
        let url = getDocumentsDirectory().appendingPathComponent("thoughts.json")
        do {
            let data = try Data(contentsOf: url)
            savedThoughts = try JSONDecoder().decode([Thought].self, from: data)
        } catch {
            print("Error loading thoughts: \(error)")
        }
    }
    
    private func clearThoughts() {
        savedThoughts.removeAll()
        saveThoughtsToFile() // Aggiorna il file con la lista vuota
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

// Struttura per rappresentare un pensiero con uno stato d'animo
struct Thought: Identifiable, Codable {
    var id = UUID()
    let text: String
    let emotion: String
}

// Estensione per chiudere la tastiera
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// Stile personalizzato per i pulsanti di emozione
struct EmotionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .padding()
            .background(Color.blue.opacity(configuration.isPressed ? 0.3 : 0.2))
            .cornerRadius(8)
    }
}

#Preview {
    AwarenessTrainingView()
}
