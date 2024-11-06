//
//  FacialExpressionAnalysisView.swift
//  SirVolare
//
//  Created by Tulli-OS on 31/10/24.
//

import SwiftUI
import AVFoundation
import CoreMotion
import CoreML
import SoundAnalysis

struct AnxietyAnalysisView: View {
    
    @EnvironmentObject var appState: AppState
    @State private var isRecording = false
    @State private var motionManager = CMMotionManager()
    @State private var tremorValues: [Double] = []
    @State private var showEssay = false
    @State private var timer: Timer?
    @State private var anxietyMessage: String = ""
    @State private var analysisDone: Bool = false
    @State private var isButtonsDisabled = false
    @State private var feedbackAnxiety: Double = 0.0
    private var cameraManager = CameraManager() // Manager per gestire la sessione della fotocamera
    private var emoRec = EmotionRecognition()
    
    
    @State var audioFileURL: URL?
    @State var observer: ResultsObserver
    let audioSession = AVAudioSession.sharedInstance()
    @State var audioRecorder: AVAudioRecorder?
    @EnvironmentObject var ideidentifier: ResultsObserver
    
    
    let essayText = "Please read this short text aloud so we can understand which therapy is best for you."
    
    init(audioFileURL: URL, observer: ResultsObserver) {
        self.audioFileURL = audioFileURL
        self.observer = observer
    }
    
    var body: some View {
        ZStack {
            Image("sfondo")
                .resizable()
                .frame(width: 1*UIScreen.main.bounds.width, height: 1*UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
            
        VStack {
            Spacer()
            Text("How do you feel?")
                .bold()
            
            
            
            HStack {
                feedbackButton(feedback: 1, imageName: "hand.thumbsdown.fill", color: .red)
                feedbackButton(feedback: 0.5, imageName: "hand.raised.fingers.spread.fill", color: .yellow)
                feedbackButton(feedback: 0, imageName: "hand.thumbsup.fill", color: .green)
            }
            .padding()
            
            
            
            Spacer()
            
            if showEssay {
                Text(essayText)
                    .bold()
                    .padding()
                    .transition(.opacity)
                
            }
            
            
            //let averageTremor = tremorValues.isEmpty ? 0.0 : tremorValues.reduce(0, +) / Double(tremorValues.count)
            //Text("Tremore medio: \(averageTremor, specifier: "%.2f")")
            //.padding()
            
            VStack {
                Spacer()
                Text("How do you feel?")
                    .bold()
                
                
                
                HStack {
                    feedbackButton(feedback: 1, imageName: "hand.thumbsdown.fill", color: .red)
                    feedbackButton(feedback: 0.5, imageName: "hand.raised.fingers.spread.fill", color: .yellow)
                    feedbackButton(feedback: 0, imageName: "hand.thumbsup.fill", color: .green)
                }
                .padding()
                
                
                
                Spacer()
                
                if showEssay {
                    Text(essayText)
                        .bold()
                        .padding()
                        .transition(.opacity)
                }
                
                
                //let averageTremor = tremorValues.isEmpty ? 0.0 : tremorValues.reduce(0, +) / Double(tremorValues.count)
                //Text("Tremore medio: \(averageTremor, specifier: "%.2f")")
                //.padding()
                
                /*
                 // Visualizzazione del messaggio di ansia
                 Text(anxietyMessage)
                 .font(.headline)
                 .foregroundColor(anxietyMessage.isEmpty ? .clear : .black)
                 .padding()
                 
                 */
                
                
                NavigationLink(destination: therapyView(for: appState.anxietyLevel), isActive: $analysisDone) {
                    EmptyView()
                }
                
                /*
                 Spacer()
                 //NavigationLink(destination: RelaxationTechniqueView()) {
                 NavigationLink(destination: therapyView(for: appState.anxietyLevel)) {
                 Text("Proceed to Therapy")
                 .font(.system(size: 25, weight: .light, design: .rounded))
                 .frame(maxWidth: .infinity)
                 .padding()
                 .background(Color.blue)
                 .foregroundColor(.white)
                 .cornerRadius(10)
                 .padding(.horizontal)
                 }
                 //.navigationTitle("Anxiety Analysis")
                 
                 */
                Spacer()
            }
        }
        .padding()
        .onAppear {
            observer = ResultsObserver(result: $ideidentifier.result)
        }
    }
    
    
    
    private func feedbackButton(feedback: Double, imageName: String, color: Color) -> some View {
        Button(action: {
            handleFeedback(feedback)
            isButtonsDisabled = true
        }) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(color)
        }
        .padding()
        .disabled(isButtonsDisabled)
        
    }
    
    
    // MARK: - Feedback Handling
    func handleFeedback(_ feedback: Double) {
        showEssay = true
        appState.userFeedback = feedback
        
        startAudioRecording()
        startTremorDetection()
        
        cameraManager.startCapture { image in
            //self.capturedImage = image
            emoRec.loadImageAndDetect(capturedImage: image) { risultato in
                if (risultato != "FELICE" && risultato != "PREOCCUPATO") {
                    print("Errore 0001")
                } else {
                    if (risultato == "FELICE") {
                        appState.faceExpressionScore = 0
                    } else {
                        appState.faceExpressionScore = 1
                    }
                }
            }
        }
        
        anxietyMessage = ""
        
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            stopRecording()
            stopTremorDetection()
            showEssay = false
            analysisDone = true
            isButtonsDisabled = false
            
            DispatchQueue.main.async {
                appState.voiceTremor = mapAnxietyLevel()
                updateAnxietyMessage()  // Una volta completata l'analisi vocale, aggiorna il messaggio
            }
        }
    }
    
    // MARK: - Audio Recording
    func startAudioRecording() {
        audioRecorder?.record(forDuration: 5)
        isRecording = true
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
        analyzeAudio()
    }
    
    // MARK: - Voice Analysis
    func analyzeAudio() {
        guard let audioFileURL = audioFileURL else {
            print("No audio file available for analysis.")
            return
        }
        
        let audioFileAnalyzer = try! SNAudioFileAnalyzer(url: audioFileURL)
        let request = try! SNClassifySoundRequest(mlModel: VoiceClassifier().model)
        
        do {
            try audioFileAnalyzer.add(request, withObserver: observer)
            audioFileAnalyzer.analyze()
        } catch {
            print("Failed to analyze audio: \(error)")
        }
    }
    
    func mapAnxietyLevel() -> Double {
        // Dividi la stringa utilizzando ":" come separatore
        let parts = ideidentifier.result.split(separator: ":")
        
        
        
        // Se la divisione ha successo e c'è almeno una parte
        if let firstPart = parts.first {
            let target = String(firstPart)  // Converti la prima parte in String
            
            print("!!!!!! \(target)")
            
            switch target {
            case "neutral": // Non Ansioso
                return 0.0
            case "anxiety": // Ansioso
                return 1.0
            default:
                return -1.0
            }
        } else {
            // Se non c'è alcuna parte da analizzare, restituisci un valore di default
            print("Il formato del risultato non è corretto.")
            return -1.0
        }
    }
    
    // MARK: - Tremor Detection
    func startTremorDetection() {
        guard motionManager.isAccelerometerAvailable else { return }
        
        motionManager.accelerometerUpdateInterval = 0.01
        tremorValues.removeAll()
        
        
        motionManager.startAccelerometerUpdates(to: .main) { data, error in
            if let data = data {
                
                //print("Hand Tremor axe X: \(data.acceleration.x)")
                //print("Hand Tremor axe Y: \(data.acceleration.y)")
                //print("Hand Tremor axe Z: \(data.acceleration.z)")
                
                let currentTremorValue = sqrt(data.acceleration.x * data.acceleration.x +
                                              data.acceleration.y * data.acceleration.y +
                                              data.acceleration.z * data.acceleration.z)
                //print("SQRT \(currentTremorValue)")
                self.tremorValues.append(currentTremorValue)
            }
        }
    }
    
    func stopTremorDetection() {
        motionManager.stopAccelerometerUpdates()
        
        let filteredTremorValues = tremorValues.filter { $0 >= 1.0 }
        let averageTremor = filteredTremorValues.isEmpty ? 0.0 : filteredTremorValues.reduce(0, +) / Double(filteredTremorValues.count)
        
        let anxietyLevel = evaluateAnxietyLevel(from: averageTremor)
        appState.handTremor = anxietyLevel
        
        //print("Hand Tremor Level: \(anxietyLevel)")
    }
    
    func evaluateAnxietyLevel(from averageTremor: Double) -> Double {
        let restValue: Double = 1.0
        
        if averageTremor <= restValue + 0.05 {
            return 0 // Non ansioso
        } else if  averageTremor < restValue + 0.15 {
            return 0.5 // Poco ansioso
        } else {
            return 1 // Molto ansioso
        }
    }
    
    func updateAnxietyMessage() {
        let facialAnxiety = appState.faceExpressionScore // Supponiamo sia normalizzato tra 0 e 1
        let vocalAnxiety = appState.voiceTremor // Supponiamo sia normalizzato tra 0 e 1
        let handAnxiety = appState.handTremor // Supponiamo sia normalizzato tra 0 e 1
        let feedbackAnxiety = appState.userFeedback // Supponiamo sia normalizzato tra 0 e 1
        
        // Calcolo dell'ansia totale pesato
        let totalAnxiety = (facialAnxiety * 0.40) + (vocalAnxiety * 0.20) + (handAnxiety * 0.20) + (feedbackAnxiety * 0.20)
        
        // Aggiorna lo stato dell'ansia e il messaggio corrispondente
        appState.anxietyLevel = totalAnxiety
        
        print("Facial Anxiety Value: \(facialAnxiety) - Facial Anxiety Normalized: \(facialAnxiety * 0.40)")
        print("Vocal Anxiety Value: \(vocalAnxiety) - Vocal Anxiety Normalized: \(vocalAnxiety * 0.20)")
        print("Hand Anxiety Value: \(handAnxiety) - Hand Anxiety Normalized: \(handAnxiety * 0.20)")
        print("Feedback Anxiety Value: \(feedbackAnxiety) - Feedback Anxiety Normalized: \(feedbackAnxiety * 0.20)")
        print("Total Anxiety Score: \(totalAnxiety)")
        
        anxietyMessage = generateAnxietyMessage(for: totalAnxiety)
    }
    
    func generateAnxietyMessage(for anxietyLevel: Double) -> String {
        switch anxietyLevel {
        case 0.0..<0.25:
            return "You are feeling relaxed."
        case 0.25..<0.5:
            return "You are feeling a bit anxious."
        case 0.5...1.0:
            return "You are feeling very anxious."
        default:
            return ""
        }
    }
    
    
    func therapyView(for anxietyLevel: Double) -> some View {
        
        let daysUntilDeparture = daysUntilDeparture(from: appState.flightDate)
        
        
        
        if daysUntilDeparture <= 2 {                                                // Se stai per partire o mancano due giorni
            if anxietyLevel >= 0.5 {                                                    // Se viene rilevata molta ansia
                return AnyView(AutogenicTrainingView())                                     // Terapia cognitivo-comportamentale
            } else {                                                                    // Se viene poca molta ansia
                return AnyView(AwarenessTrainingView())                                     // Tecniche di rilassamento immediato
            }
        } else {                                                                    // Se mancano piu di 2 giorni alla partenza
            if anxietyLevel >= 0.5 {                                                    // Se viene rilevata molta ansia
                return AnyView(CognitiveBehavioralTherapyView())                            // Terapia cognitivo-comportamentale
            } else {                                                                    // Se viene poca molta ansia
                return AnyView(AwarenessTrainingView())                                     // Allenamento per l'autoconsapevolezza
            }
        }
        
        
        /*
         if daysUntilDeparture > 2 {
         if anxietyLevel < 0.5 { // Poco o per nulla ansioso
         return AnyView(AwarenessTrainingView()) // Allenamento per l'autoconsapevolezza
         } else { // Molto ansioso
         return AnyView(AutogenicTrainingView()) // Tecniche di rilassamento immediato
         }
         } else if daysUntilDeparture > 0 {
         if anxietyLevel < 0.5 { // Poco o per nulla ansioso
         return AnyView(AutogenicTrainingView()) // Tecniche di rilassamento immediato
         } else { // Molto ansioso
         return AnyView(CognitiveBehavioralTherapyView()) // Terapia cognitivo-comportamentale
         }
         } else {
         return AnyView(CognitiveBehavioralTherapyView()) // Terapia cognitivo-comportamentale
         }
         */
    }
    
    
    private func daysUntilDeparture(from date: Date) -> Int {
        let calendar = Calendar.current
        let today = Date()
        return calendar.dateComponents([.day], from: today, to: date).day ?? 0
    }
    
    
    
    
    
    
    
    
}

#Preview {
    //let appState = AppState()
    // AnxietyAnalysisView(appState: appState)
}

class ResultsObserver: NSObject, SNResultsObserving, ObservableObject {
    
    @Binding var classificationResult: String
    private var classificationConfidences: [String: [Double]] = [:]  // Dizionario per memorizzare le confidenze di ogni etichetta
    @Published var result: String = ""
    
    init(result: Binding<String>) {
        _classificationResult = result
    }
    
    func request(_ request: SNRequest, didProduce result: SNResult) {
        
        //var identifierReturn: String = ""
        
        guard let result = result as? SNClassificationResult else {
            return
        }
        
        // Per ogni classificazione prodotta, aggiorna il dizionario delle confidenze
        if let classification = result.classifications.first {
            let identifier = classification.identifier
            let confidence = classification.confidence
            
            // Aggiungi la confidenza per questa etichetta
            if classificationConfidences[identifier] == nil {
                classificationConfidences[identifier] = [confidence]
            } else {
                classificationConfidences[identifier]?.append(confidence)
            }
            
            // Stampa i valori intermedi per il debug
            print("Predizione per \(identifier) con confidenza \(confidence)")
            print("Confidenze accumulate per \(identifier): \(classificationConfidences[identifier]!)")
            
        }
        //return identifierReturn
    }
    
    func request(_ request: SNRequest, didFailWithError error: Error) {
        print("The analysis failed: \(error.localizedDescription)")
    }
    
    func requestDidComplete(_ request: SNRequest) {
        // Calcolare la media ponderata delle confidenze per ogni etichetta
        var finalResults: [String: Double] = [:]
        
        print("\nCalcolando la media ponderata delle confidenze per ciascuna etichetta...")
        
        // Per ogni etichetta, calcoliamo la media delle confidenze
        for (label, confidences) in classificationConfidences {
            let totalConfidence = confidences.reduce(0, +) // Somma delle confidenze
            let count = confidences.count // Numero di predizioni
            
            // Calcolare la media ponderata (media semplice in questo caso, visto che ogni predizione ha lo stesso peso)
            let averageConfidence = totalConfidence / Double(count)
            finalResults[label] = averageConfidence
            
            // Stampa la media per ciascuna etichetta
            print("Per \(label): somma delle confidenze = \(totalConfidence), numero di predizioni = \(count), media della confidenza = \(averageConfidence)")
        }
        
        // Trovare l'etichetta con la confidenza media più alta
        if let bestLabel = finalResults.max(by: { $0.value < $1.value }) {
            let percent = bestLabel.value * 100.0
            DispatchQueue.main.async {
                self.classificationResult = "\(bestLabel.key): \(String(format: "%.2f", percent))%"
            }
            // Stampa il risultato finale
            print("\nRisultato finale: \(bestLabel.key) con confidenza \(String(format: "%.2f", percent))%")
        } else {
            DispatchQueue.main.async {
                self.classificationResult = "No classification result."
            }
        }
        
        print("The request completed successfully!")
        
        // Reset dei dizionari per la prossima registrazione
        resetData()
    }
    
    // Funzione per resettare i dizionari
    private func resetData() {
        classificationConfidences.removeAll()
        
        // Stampa del reset
        print("\nDizionari resettati per la prossima analisi.")
    }
}
