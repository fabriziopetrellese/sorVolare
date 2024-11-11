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
    
    @FocusState private var isKeyboardVisible: Bool // FocusState per monitorare la tastiera
    
    var body: some View {
        ZStack {
            Image("sfondo")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("CBT Therapy")
                    .font(.largeTitle)
                    .padding()
                
                // Sezione per il campo di input e il pulsante "Salva Pensiero"
                if !isThoughtAnalyzed {
                    TextField("Write what worries you", text: $negativeThought)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .focused($isKeyboardVisible) // Associa il campo di testo al FocusState
                    
                    Button("Save Thought") {
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
                    Button("Analyzes Thought") {
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
                    Text("Analysis: \(analysisResult)")
                        .padding()
                }
                
                // Sezione per il pensiero positivo (campo di input)
                if isThoughtAnalyzed {
                    VStack {
                        Text("Rewrite your thought in a positive way:")
                            .font(.headline)
                            .padding()
                        
                        TextField("Es. I am capable of overcoming this situation", text: $positiveThought)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .foregroundColor(.green)
                            .focused($isKeyboardVisible) // Focus per questo TextField
                        
                        // Pulsante per salvare il pensiero positivo
                        Button("Save positive thought") {
                            // Logica per salvare il pensiero positivo, se necessario
                            savedNegativeThoughts.append("Positive: \(positiveThought)") // Salva il pensiero positivo
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
                        Button("New thought") {
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
            .toolbar {
                // Aggiungi il pulsante "Fine" sopra la tastiera
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isKeyboardVisible = false // Chiude la tastiera
                    }
                }
            }
        }
        .onAppear {
            loadSavedNegativeThoughts()
        }
    }
    
    private func writeThought(_ pensiero: String) -> String {
        return "This is what you wrote: \(pensiero).  \n Now read it aloud and reflect on why you wrote that."
    }
    
    private func analyzeThought(_ thought: String) -> String {
        return "You wrote: \(thought). \n Rephrase it in a positive way "
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
            print("Error in saving negative thoughts: \(error)")
        }
    }
    
    private func loadSavedNegativeThoughts() {
        let url = getDocumentsDirectory().appendingPathComponent("negativeThoughts.json")
        do {
            let data = try Data(contentsOf: url)
            savedNegativeThoughts = try JSONDecoder().decode([String].self, from: data)
        } catch {
            print("Error in loading negative thoughts: \(error)")
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
            .navigationTitle("Saved Thoughts")
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
