//
//  SelfAwarenessSessionView.swift
//  SirVolare
//
//  Created by Tulli-OS on 31/10/24.
//

import SwiftUI

struct AwarenessTrainingView: View {
    @State private var isMeditating: Bool = false
    @State private var currentPhase: Int = 0
    @State private var meditationTimer: Timer?
    @State private var thoughts: String = ""
    @State private var savedThoughts: [String] = []
    
    private let phases = [
        "Prenditi un momento per riflettere... 🌟",
        "Scrivi tre cose per cui sei grato... 📝",
        "Rilassati e ascolta il tuo respiro... 🌬️",
        "Chiudi gli occhi e rifletti... 🧘‍♂️"
    ]
    
    var body: some View {
        VStack {
            Text("Autoconsapevolezza")
                .font(.largeTitle)
                .padding()
            
            Text(phases[currentPhase])
                .font(.title)
                .padding()
            
            if isMeditating {
                TextField("Scrivi qui i tuoi pensieri...", text: $thoughts)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(height: 100)
                
                Button("Salva Pensiero") {
                    saveThought(thoughts)
                    thoughts = "" // Resetta il campo di testo
                }
                .padding()
            }
            
            Button(action: {
                isMeditating ? stopMeditation() : startMeditation()
            }) {
                Text(isMeditating ? "Ferma Meditazione" : "Inizia Meditazione")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            List(savedThoughts, id: \.self) { thought in
                Text(thought)
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
    
    private func saveThought(_ thought: String) {
        savedThoughts.append(thought)
        saveThoughtsToFile()
    }
    
    private func saveThoughtsToFile() {
        do {
            let data = try JSONEncoder().encode(savedThoughts)
            let url = getDocumentsDirectory().appendingPathComponent("thoughts.json")
            try data.write(to: url)
        } catch {
            print("Errore nel salvataggio dei pensieri: \(error)")
        }
    }
    
    private func loadSavedThoughts() {
        let url = getDocumentsDirectory().appendingPathComponent("thoughts.json")
        do {
            let data = try Data(contentsOf: url)
            savedThoughts = try JSONDecoder().decode([String].self, from: data)
        } catch {
            print("Errore nel caricamento dei pensieri: \(error)")
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

#Preview {
    AwarenessTrainingView()
}
