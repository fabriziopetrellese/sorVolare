//
//  AppState.swift
//  SirVolare
//
//  Created by Tulli-OS on 31/10/24.
//

import UIKit

class AppState: ObservableObject {
    // Variabili condivise per i dati di volo
    @Published var flightDate: Date = Date()
    //@Published var destination: String = ""
    @Published var currentView: CurrentView = .welcome
    
    // Stato dell'ansia
    @Published var anxietyLevel: Double = 0
    @Published var handTremor: Double = 0
    @Published var voiceTremor: Double = 0
    @Published var faceExpressionScore: Double = 0
    @Published var userFeedback: Double = 0
    
    @Published var selectedTechnique: RelaxationTechnique = .none
    
    // Tecnica di rilassamento selezionata
    enum RelaxationTechnique {
        case cbt, selfAwareness, autogenicTraining, none
    }
    
    enum CurrentView {
        case welcome
        case autogenic
        case awareness
        case cbt
        case scan
    }
    
    /*
    func calculateAnxietyLevel() {
        let tremor = handTremor * 0.2 // attribuire un valore normalizzato rispetto al peso
        let frequency = voiceTremor * 0.2 // attribuire un valore normalizzato rispetto al peso
        let expression = faceExpressionScore * 0.4   // attribuire un valore normalizzato rispetto al peso
        let user = userFeedback * 0.2 // il valore deve avere un peso inferiore in quanto potrebbe essere sfalsato
        
        anxietyLevel = tremor + frequency + expression + user
        // anxietyLevel = min(max(anxietyLevel, 0), 10)
    }
     */

    
}
