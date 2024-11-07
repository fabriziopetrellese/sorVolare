import SwiftUI

struct CognitiveBehavioralTherapyView: View {
    
    @State private var negativeThought: String = ""
    @State private var positiveThought: String = "" // Variabile per il pensiero positivo che l'utente scriverà
    @State private var analysisResult: String = ""
    @State private var writeResult: String = ""
    @State private var savedNegativeThoughts: [String] = []
    @State private var isThoughtSaved: Bool = false // Indica se un pensiero è stato salvato
    @State private var isThoughtAnalyzed: Bool = false // Indica se un pensiero è stato analizzato
    @State private var isShowingSavedThoughts: Bool = false // Stato per presentare il foglio modale
    
    var body: some View {
        ZStack {
            Image("sfondo")
                .resizable()
                .frame(width: 1 * UIScreen.main.bounds.width, height: 1 * UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("CBT Therapy")
                    .font(.largeTitle)
                    .padding()
                
                // Sezione per il campo di input e il pulsante "Salva Pensiero"
                if !isThoughtAnalyzed {
                    TextField("Scrivi un pensiero negativo", text: $negativeThought)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button("Salva Pensiero") {
                        writeResult = writeThought(negativeThought)
                        saveNegativeThought(negativeThought)
                        negativeThought = "" // Resetta il campo di testo
                        isThoughtSaved = true // Indica che il pensiero è stato salvato
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .font(.subheadline)
                    .background(Color.cyan.opacity(0.3))
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    
                    if !writeResult.isEmpty {
                        Text(writeResult)
                        Image(systemName: "megaphone")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                }
                
                // Pulsante "Analizza Pensiero" visibile solo se è stato salvato un pensiero
                if isThoughtSaved && !isThoughtAnalyzed {
                    Button("Analizza Pensiero") {
                        analysisResult = analyzeThought(savedNegativeThoughts.last ?? "")
                        isThoughtAnalyzed = true // Segna il pensiero come analizzato e nasconde l'input
                        isThoughtSaved = false // Disabilita "Analizza" per il prossimo pensiero
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .font(.subheadline)
                    .background(Color.cyan.opacity(0.3))
                    .cornerRadius(10)
                    .foregroundColor(.black)
                }
                
                // Mostra il risultato dell'analisi solo dopo che è stato generato
                if !analysisResult.isEmpty {
                    Text("Analisi: \(analysisResult)")
                        .padding()
                }
                
                // Sezione per il pensiero positivo (campo di input)
                if isThoughtAnalyzed {
                    VStack {
                        Text("Riscrivi il pensiero in modo positivo:")
                            .font(.headline)
                            .padding()
                        
                        TextField("Es. Sono capace di superare questa situazione", text: $positiveThought)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .foregroundColor(.green)
                        
                        // Pulsante per salvare il pensiero positivo
                        Button("Salva Pensiero Positivo") {
                            // Logica per salvare il pensiero positivo, se necessario
                            savedNegativeThoughts.append("Positivo: \(positiveThought)") // Salva il pensiero positivo
                            saveNegativeThoughtsToFile() // Salva nel file
                            positiveThought = "" // Resetta il pensiero positivo
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .font(.subheadline)
                        .background(Color.green.opacity(0.3))
                        .cornerRadius(10)
                        .foregroundColor(.black)
                    }
                    .padding()
                }
                
                // Sezione per i pulsanti "Nuovo Pensiero" e "Past Thoughts" accanto
                HStack {
                    // Pulsante "Nuovo Pensiero"
                    if isThoughtAnalyzed {
                        Button("Nuovo Pensiero") {
                            // Resetta per permettere di inserire un nuovo pensiero
                            analysisResult = ""
                            writeResult = ""
                            isThoughtAnalyzed = false // Rende visibile l'input per un nuovo pensiero
                            positiveThought = "" // Resetta il pensiero positivo
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .font(.subheadline)
                        .background(Color.cyan.opacity(0.3))
                        .cornerRadius(10)
                        .foregroundColor(.black)
                    }
                    
                    // Pulsante "Past Thoughts"
                    Button("Past Thoughts") {
                        isShowingSavedThoughts = true
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .font(.subheadline)
                    .background(Color.cyan.opacity(0.3))
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    .sheet(isPresented: $isShowingSavedThoughts) {
                        SavedThoughtsView(thoughts: $savedNegativeThoughts, saveNegativeThoughtsToFile: saveNegativeThoughtsToFile)
                    }
                }
            }
        }
        .onAppear {
            loadSavedNegativeThoughts()
        }
    }
    
    private func writeThought(_ pensiero: String) -> String {
        return "Questo è ciò che hai scritto: \(pensiero).  \n Ora leggilo ad alta voce e rifletti sul perché hai scritto ciò."
    }
    
    private func analyzeThought(_ thought: String) -> String {
        return "Hai scritto: \(thought). Riformulalo in modo positivo."
    }
    
    private func saveNegativeThought(_ thought: String) {
        savedNegativeThoughts.append(thought)
        saveNegativeThoughtsToFile() // Salva i pensieri nel file
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

// Vista modale per mostrare la lista dei pensieri salvati
struct SavedThoughtsView: View {
    @Binding var thoughts: [String]
    var saveNegativeThoughtsToFile: () -> Void
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List(thoughts.reversed(), id: \.self) { thought in
                Text(thought)
            }
            .navigationTitle("Pensieri Salvati")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Clean Up") {
                        thoughts.removeAll()
                        saveNegativeThoughtsToFile()
                    }
                    .foregroundColor(.red)
                }
            }
        }
    }
}

#Preview {
    CognitiveBehavioralTherapyView()
}
