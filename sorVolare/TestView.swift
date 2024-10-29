//
//  TestView.swift
//  sorVolare
//
//  Created by Tulli-OS on 28/10/24.
//

import SwiftUI

struct TestView: View {
    
    
    var body: some View {
        
        Text("")
    }
    
    
    
    
    
    
    
    
    
    
    /*
    @State private var currentStep = 0
        @State private var score = 0
        @State private var health = 100
        @State private var feedback: String = ""
        
        let scenarios: [(String, [String], [Int], [Int])] = [
            ("Sei sull'aereo e inizia a sentirti ansioso. Cosa fai?", ["Pratichi respirazione profonda", "Inizi a parlare con il vicino"], [10, 5], [-5, 0]),
            ("La turbolenza inizia. Vuoi rimanere calmo o chiedere aiuto al personale?", ["Rimani calmo", "Chiedi aiuto"], [15, 10], [0, -10]),
            ("L'aereo ha un problema tecnico. Vuoi ascoltare le istruzioni o ignorare?", ["Ascolta", "Ignora"], [20, -10], [0, -20]),
            ("Sei atterrato. Vuoi festeggiare o uscire subito dall'aeroporto?", ["Festeggia", "Esci subito"], [5, 10], [0, 5]),
        ]

        var body: some View {
            VStack {
                Text(scenarios[currentStep].0)
                    .font(.title)
                    .padding()

                ForEach(0..<scenarios[currentStep].1.count, id: \.self) { index in
                    Button(scenarios[currentStep].1[index]) {
                        handleChoice(index)
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }

                Text("Punteggio: \(score)")
                    .padding()
                Text("Salute mentale: \(health)")
                    .padding()
                Text(feedback)
                    .foregroundColor(.green)
                    .padding()
            }
            .padding()
        }

        private func handleChoice(_ index: Int) {
            score += scenarios[currentStep].2[index]
            health += scenarios[currentStep].3[index]
            feedback = "Hai guadagnato \(scenarios[currentStep].2[index]) punti e la tua salute mentale è ora \(health)!"
            
            currentStep += 1
            
            if currentStep >= scenarios.count {
                feedback = "Hai completato il viaggio! Punteggio finale: \(score). Salute mentale finale: \(health)."
                currentStep = 0 // Riavvia il gioco
                score = 0 // Resetta il punteggio
                health = 100 // Resetta la salute mentale
            }
        }
    */
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    @State private var score = 0
        @State private var currentScenarioIndex = 0

        let scenarios = [
            ("C'è un po' di turbolenza. Come reagisci?", ["Respira profondamente", "Chiudi gli occhi"]),
            ("Un passeggero sta facendo rumore. Cosa fai?", ["Ignora", "Chiedi gentilmente di smettere"]),
        ]

        var body: some View {
            VStack {
                Text(scenarios[currentScenarioIndex].0)
                    .font(.title)
                    .padding()

                ForEach(scenarios[currentScenarioIndex].1, id: \.self) { option in
                    Button(option) {
                        handleChoice(option)
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }

                Text("Punteggio: \(score)")
                    .padding()
            }
        }

        private func handleChoice(_ choice: String) {
            score += (choice == "Respira profondamente" || choice == "Ignora") ? 10 : -5
            currentScenarioIndex = (currentScenarioIndex + 1) % scenarios.count // Avanza al prossimo scenario
        }
    */
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    @State private var currentStep = 0
        @State private var outcome = ""

        let steps = [
            ("Sei all'aeroporto. Vuoi controllare il tuo bagaglio o andare al gate?", "Controlla", "Gate"),
            ("Hai deciso di controllare il bagaglio. Vuoi comprare un libro o un snack?", "Libro", "Snack"),
            ("Hai scelto di andare al gate. Vuoi sederti vicino al finestrino o al corridoio?", "Finestrino", "Corridoio"),
        ]

        var body: some View {
            VStack {
                Text(steps[currentStep].0)
                    .font(.title)
                    .padding()

                HStack {
                    Button(steps[currentStep].1) {
                        handleChoice(steps[currentStep].1)
                    }
                    Button(steps[currentStep].2) {
                        handleChoice(steps[currentStep].2)
                    }
                }
                .padding()

                Text(outcome)
                    .padding()
            }
        }

        private func handleChoice(_ choice: String) {
            if choice == steps[currentStep].1 {
                outcome = "Hai scelto: \(choice). Ottima scelta!"
            } else {
                outcome = "Hai scelto: \(choice). Speriamo sia rilassante!"
            }

            currentStep += 1
            if currentStep >= steps.count {
                outcome += "\nHai completato il tuo viaggio!"
            }
        }
    */
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    
    
    @State private var isBreathingIn = true
        @State private var progress: Double = 0.0
        @State private var timer: Timer? = nil

        var body: some View {
            VStack {
                Text(isBreathingIn ? "Inspira" : "Espira")
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
     
     */
    

    
    
    
    
    
    
    
}

#Preview {
    TestView()
}
