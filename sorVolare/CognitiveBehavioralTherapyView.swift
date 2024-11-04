//
//  CBTSessionView.swift
//  SirVolare
//
//  Created by Tulli-OS on 31/10/24.
//

import SwiftUI

struct CognitiveBehavioralTherapyView: View {
    
    @State private var negativeThought: String = ""
    @State private var analysisResult: String = ""
    @State private var savedNegativeThoughts: [String] = []
    
    var body: some View {
        VStack {
            Text("CBT Therapy")
                .font(.largeTitle)
                .padding()
            
            TextField("Scrivi un pensiero negativo", text: $negativeThought)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Analizza Pensiero") {
                analysisResult = analyzeThought(negativeThought)
                saveNegativeThought(negativeThought)
                negativeThought = "" // Resetta il campo di testo
            }
            .padding()
            
            if !analysisResult.isEmpty {
                Text("Analisi: \(analysisResult)")
                    .padding()
            }
            
            List(savedNegativeThoughts, id: \.self) { thought in
                Text(thought)
            }
        }
        .onAppear {
            loadSavedNegativeThoughts()
        }
    }
    
    private func analyzeThought(_ thought: String) -> String {
        return "Hai scritto: \(thought). Riformulalo in modo positivo."
    }
    
    private func saveNegativeThought(_ thought: String) {
        savedNegativeThoughts.append(thought)
        saveNegativeThoughtsToFile()
    }
    
    private func saveNegativeThoughtsToFile() {
        do {
            let data = try JSONEncoder().encode(savedNegativeThoughts)
            let url = getDocumentsDirectory().appendingPathComponent("negativeThoughts.json")
            try data.write(to: url)
        } catch {
            print("Errore nel salvataggio dei pensieri negativi: \(error)")
        }
    }
    
    private func loadSavedNegativeThoughts() {
        let url = getDocumentsDirectory().appendingPathComponent("negativeThoughts.json")
        do {
            let data = try Data(contentsOf: url)
            savedNegativeThoughts = try JSONDecoder().decode([String].self, from: data)
        } catch {
            print("Errore nel caricamento dei pensieri negativi: \(error)")
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

#Preview {
    CognitiveBehavioralTherapyView()
}
