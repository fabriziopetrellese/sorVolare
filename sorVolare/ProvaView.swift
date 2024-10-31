import SwiftUI

struct ContentView1: View {
    @State private var showModal = false
    
    var body: some View {
        VStack {
            Button("Mostra Modale") {
                showModal = true
            }
        }
        .sheet(isPresented: $showModal) {
            // La vista del modale
            ModalView()
        }
    }
}

struct ModalView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Questo è un modale")
                .font(.title)
            Button("Chiudi") {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .padding()
    }
}
#Preview {
    ContentView1()
}
