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

struct AnxietyAnalysisView: View {
    
    @EnvironmentObject var appState: AppState
    @State private var audioRecorder: AVAudioRecorder?
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
    
    let essayText = "Per favore, leggi questo breve saggio in modo che possiamo capire quale terapia è più indicata."
    
    var body: some View {
        VStack {
            Spacer()
            Text("How do you feel?")
                .font(.title2)
            
           
                
            HStack {
                feedbackButton(feedback: 1, imageName: "hand.thumbsdown", color: .red)
                feedbackButton(feedback: 0.5, imageName: "hand.raised.fingers.spread", color: .yellow)
                feedbackButton(feedback: 0, imageName: "hand.thumbsup", color: .green)
            }
            .padding()
            
    
            
            Spacer()
            
            if showEssay {
                Text(essayText)
                    .padding()
                    .transition(.opacity)
            }
            
            
            //let averageTremor = tremorValues.isEmpty ? 0.0 : tremorValues.reduce(0, +) / Double(tremorValues.count)
            //Text("Tremore medio: \(averageTremor, specifier: "%.2f")")
            //.padding()
            
            // Visualizzazione del messaggio di ansia
            Text(anxietyMessage)
                .font(.headline)
                .foregroundColor(anxietyMessage.isEmpty ? .clear : .black)
                .padding()
            
            
            
            
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
        }
        .padding()
        .onAppear {
            setupAudioRecorder()
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
        //capturePhoto() // Da implementare
        
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
            updateAnxietyMessage()
            analysisDone = true
            isButtonsDisabled = false
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
        analyzeVoiceTremor()
    }
    
    // MARK: - Voice Analysis
    func analyzeVoiceTremor() {
        guard let audioFileURL = audioRecorder?.url, FileManager.default.fileExists(atPath: audioFileURL.path) else {
            print("File audio non disponibile.")
            return
        }
        
        do {
            let audioFile = try AVAudioFile(forReading: audioFileURL)
            let buffer = AVAudioPCMBuffer(pcmFormat: audioFile.processingFormat, frameCapacity: AVAudioFrameCount(audioFile.length))
            try audioFile.read(into: buffer!)
            
            let features = try extractFeatures(from: buffer!)
            let model = try VoiceClassifier(configuration: MLModelConfiguration())
            let prediction = try model.prediction(input: features)
            
            let anxietyLevel = mapAnxietyLevel(from: prediction.target)
            appState.voiceTremor = anxietyLevel
            
            print("Voice Anxiety Level: \(anxietyLevel)")
        } catch {
            print("Errore nell'aprire il file audio: \(error.localizedDescription)")
        }
    }
    
    func extractFeatures(from buffer: AVAudioPCMBuffer) throws -> VoiceClassifierInput {
        let frameCount = buffer.frameLength
        guard let channelData = buffer.floatChannelData?[0] else {
            throw NSError(domain: "AudioProcessing", code: 1, userInfo: [NSLocalizedDescriptionKey: "No channel data available"])
        }
        
        let audioSamples = try MLMultiArray(shape: [NSNumber(value: 15600)], dataType: .float32)
        
        for i in 0..<min(Int(frameCount), 15600) {
            audioSamples[i] = NSNumber(value: channelData[i])
        }
        
        return VoiceClassifierInput(audioSamples: audioSamples)
    }
    
    // MARK: - Audio Setup
    func setupAudioRecorder() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
        } catch {
            print("Errore nella registrazione audio: \(error)")
        }
    }
    
    func mapAnxietyLevel(from target: String) -> Double {
        switch target {
        case "Non Ansioso":
            return 0.0
        case "Ansioso":
            return 1.0
        default:
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
        let totalAnxiety = (facialAnxiety * 0.35) + (vocalAnxiety * 0.25) + (handAnxiety * 0.25) + (feedbackAnxiety * 0.15)
        
        // Aggiorna lo stato dell'ansia e il messaggio corrispondente
        appState.anxietyLevel = totalAnxiety
        
        print("Facial Anxiety Value: \(facialAnxiety) - Facial Anxiety Normalized: \(facialAnxiety * 0.35)")
        print("Vocal Anxiety Value: \(vocalAnxiety) - Vocal Anxiety Normalized: \(vocalAnxiety * 0.25)")
        print("Hand Anxiety Value: \(handAnxiety) - Hand Anxiety Normalized: \(handAnxiety * 0.25)")
        print("Feedback Anxiety Value: \(feedbackAnxiety) - Feedback Anxiety Normalized: \(feedbackAnxiety * 0.15)")
        print("Total Anxiety Score: \(totalAnxiety)")
        
        anxietyMessage = generateAnxietyMessage(for: totalAnxiety)
    }
    
    func generateAnxietyMessage(for anxietyLevel: Double) -> String {
        switch anxietyLevel {
        case 0.0..<0.25:
            return "You are feeling relaxed."
        case 0.25..<0.5:
            return "You are feeling a bit anxious."
        case 0.4...1.0:
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
    
    
    
    
    
    // MARK: - Facial Detection
    func capturePhoto() {
        // Implementa la logica per catturare la foto
        
        
     
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

#Preview {
    //let appState = AppState()
    // AnxietyAnalysisView(appState: appState)
}
